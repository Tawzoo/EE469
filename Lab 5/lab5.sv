// A full memory hierarchy. 
//
// Parameter:
// MODEL_NUMBER: A number used to specify a specific instance of the memory.  Different numbers give different hierarchies and settings.
//   This should be set to your student ID number.
// DMEM_ADDRESS_WIDTH: The number of bits of address for the memory.  Sets the total capacity of main memory.
//
// Accesses: To do an access, set address, data_in, byte_access, and write to a desired value, and set start_access to 1.
//   All these signals must be held constant until access_done, at which point the operation is completed.  On a read,
//   data_out will be set to the correct data for the single cycle when access_done is true.  Note that you can do
//   back-to-back accesses - when access_done is true, if you keep start_access true the memory will start the next access.
// 
//   When start_access = 0, the other input values do not matter.
//   bytemask controls which bytes are actually written (ignored on a read).
//     If bytemask[i] == 1, we do write the byte from data_in[8*i+7 : 8*i] to memory at the corresponding position.  If == 0, that byte not written.
//   To do a read: write = 0,  data_in does not matter.  data_out will have the proper data for the single cycle where access_done==1.
//   On a write, write = 1 and data_in must have the data to write.
//
//   Addresses must be aligned.  Since this is a 64-bit memory (8 bytes), the bottom 3 bits of each address must be 0.
//
//   It is an error to set start_access to 1 and then either set start_access to 0 or change any other input before access_done = 1.
//
//   Accessor tasks (essentially subroutines for testbenches) are provided below to help do most kinds of accesses.

// Line to set up the timing of simulation: says units to use are ns, and smallest resolution is 10ps.
`timescale 1ns/10ps

module lab5 #(parameter [22:0] MODEL_NUMBER = 2223861, parameter DMEM_ADDRESS_WIDTH = 20) (
	// Commands:
	//   (Comes from processor).
	input		logic [DMEM_ADDRESS_WIDTH-1:0]	address,			// The byte address.  Must be word-aligned if byte_access != 1.
	input		logic [63:0]							data_in,			// The data to write.  Ignored on a read.
	input		logic [7:0]								bytemask,		// Only those bytes whose bit is set are written.  Ignored on a read.
	input		logic										write,			// 1 = write, 0 = read.
	input		logic										start_access,	// Starts a memory access.  Once this is true, all command inputs must be stable until access_done becomes 1. 
	output	logic										access_done,	// Set to true on the clock edge that the access is completed.
	output	logic	[63:0]							data_out,		// Valid when access_done == 1 and access is a read.
	// Control signals:
	input		logic										clk,
	input		logic										reset				// A reset will invalidate all cache entries, and return main memory to the default initial values.
); 
	
	DataMemory #(.MODEL_NUMBER(MODEL_NUMBER), .DMEM_ADDRESS_WIDTH(DMEM_ADDRESS_WIDTH)) dmem
		(.address, .data_in, .bytemask, .write, .start_access, .access_done, .data_out, .clk, .reset);
	
	always @(posedge clk)
		assert(reset !== 0 || start_access == 0 || address[2:0] == 0); // All accesses must be aligned.
	
endmodule

// Test the data memory, and figure out the settings.

module lab5_testbench ();
//	localparam USERID = 2223861;  // Set to your student ID #
	localparam USERID = 0;  // Set to your student ID #
	localparam ADDRESS_WIDTH = 20;
	localparam DATA_WIDTH = 8;
	
	logic [ADDRESS_WIDTH-1:0]			address;		   // The byte address.  Must be word-aligned if byte_access != 1.
	logic [63:0]							data_in;			// The data to write.  Ignored on a read.
	logic [7:0]								bytemask;		// Only those bytes whose bit is set are written.  Ignored on a read.
	logic										write;			// 1 = write, 0 = read.
	logic										start_access;	// Starts a memory access.  Once this is true, all command inputs must be stable until access_done becomes 1. 
	logic										access_done;	// Set to true on the clock edge that the access is completed.
	logic	[63:0]							data_out;		// Valid when access_done == 1 and access is a read.
	// Control signals:
	logic										clk;
	logic										reset;				// A reset will invalidate all cache entries, and return main memory to the default initial values.

	lab5 #(.MODEL_NUMBER(USERID), .DMEM_ADDRESS_WIDTH(ADDRESS_WIDTH)) dut
		(.address, .data_in, .bytemask, .write, .start_access, .access_done, .data_out, .clk, .reset); 

	// Set up the clock.
	parameter CLOCK_PERIOD=10;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 5, " ns", 10);

	// --- Keep track of number of clock cycles, for statistics.
	integer cycles;
	always @(posedge clk) begin
		if (reset)
			cycles <= 0;
		else
			cycles <= cycles + 1;
	end
		
	// --- Tasks are subroutines for doing various operations.  These provide read and write actions.
	
	// Set memory controls to an idle state, no accesses going.
	task mem_idle;
		address			<= 'x;
		data_in			<= 'x;
		bytemask			<= 'x;
		write				<= 'x;
		start_access	<= 0;
		#1;
	endtask
	
	// Perform a read, and return the resulting data in the read_data output.
	// Note: waits for complete cycle of "access_done", so spends 1 cycle more than the access time.
	task readMem;
		input		[ADDRESS_WIDTH-1:0]		read_addr;
		output	[DATA_WIDTH-1:0][7:0]	read_data;
		output	int							delay;		// Access time actually seen.
		
		int startTime, endTime;
		
		startTime = cycles;
		address			<= read_addr;
		data_in			<= 'x;
		bytemask			<= 'x;
		write				<= 0;
		start_access	<= 1;
		@(posedge clk);
		while (~access_done) begin
			@(posedge clk);
		end
		mem_idle(); #1;
		read_data = data_out;
		endTime = cycles;
		delay = endTime - startTime - 1;
	endtask
	
	function int min;
		input int x;
		input int y;
		
		min = ((x<y) ? x : y);
	endfunction
	function int max;
		input int x;
		input int y;
		
		max = ((x>y) ? x : y);
	endfunction
	
	// Perform a series of reads, and returns the min and max access times seen.
	// Accesses are at read_addr, read_addr+stride, read_addr+2*stride, ... read_addr+(num_reads-1)*stride.
	task readStride;
		input		[ADDRESS_WIDTH-1:0]		read_addr;
		input		int							stride;
		input		int							num_reads;
		output	int							min_delay;	// Fastest access time actually seen.
		output	int							max_delay;	// Slowest access time actually seen.
		
		int i, delay;
		logic [DATA_WIDTH-1:0][7:0]		read_data;
		
		//$display("%t readStride(%d, %d, %d)", $time, read_addr, stride, num_reads);
		readMem(read_addr, read_data, delay);
		min_delay = delay;
		max_delay = delay;
		//$display("1  delay: %d", delay);
		
		for(i=1; i<num_reads; i++) begin
			readMem(read_addr+stride*i, read_data, delay);
			min_delay = min(min_delay, delay);
			max_delay = max(max_delay, delay);
			//$display("2  delay: %d", delay);
		end
		//$display("%t min_delay: %d max_delay: %d", $time, min_delay, max_delay);

		mem_idle(); #1;
	endtask
	
	// Perform a write.
	// Note: waits for complete cycle of "access_done", so spends 1 cycle more than the access time.
	task writeMem;
		input [ADDRESS_WIDTH-1:0]			write_address;
		input [DATA_WIDTH-1:0][7:0]		write_data;
		input [DATA_WIDTH-1:0]				write_bytemask;
		output	int							delay;		// Access time actually seen.
		
		int	startTime, endTime;
		
		startTime = cycles;
		address			<= write_address;
		data_in			<= write_data;
		bytemask			<= write_bytemask;
		write				<= 1;
		start_access	<= 1;
		@(posedge clk);
		while (~access_done) begin
			@(posedge clk);
		end
		mem_idle(); #1;
		endTime = cycles;
		delay = endTime - startTime - 1;
	endtask
	
	// Perform a series of writes, and returns the min and max access times seen.
	// Accesses are at write_addr, write_addr+stride, write_addr+2*stride, ... write_addr+(num_writes-1)*stride.
	task writeStride;
		input		[ADDRESS_WIDTH-1:0]		write_addr;
		input		int							stride;
		input		int							num_writes;
		output	int							min_delay;	// Fastest access time actually seen.
		output	int							max_delay;	// Slowest access time actually seen.
		
		int i, delay;
		logic [DATA_WIDTH-1:0][7:0]		write_data;
		
		//$display("%t writeStride(%d, %d, %d)", $time, write_addr, stride, num_writes);
		writeMem(write_addr, write_data, 8'hFF, delay);
		min_delay = delay;
		max_delay = delay;
		//$display("1  delay: %d", delay);
		
		for(i=1; i<num_writes; i++) begin
			writeMem(write_addr+stride*i, write_data, 8'hFF, delay);
			min_delay = min(min_delay, delay);
			max_delay = max(max_delay, delay);
			//$display("2  delay: %d", delay);
		end
		//$display("%t min_delay: %d max_delay: %d", $time, min_delay, max_delay);

		mem_idle(); #1;
	endtask
	
	// Skip doing an access for a cycle.
	task noopMem;
		mem_idle();
		@(posedge clk); #1;
	endtask
	
	// Reset the memory.
	task resetMem;
		mem_idle();
		reset <= 1;
		@(posedge clk);
		reset <= 0;
		#1;
	endtask
	task test_block_size_words;
		 input int base_address;
		 input string label;
		 output int block_size_bytes;

		 int stride_bytes, delay, prev_delay;
		 logic [7:0][7:0] dummy_data;

		 $display("\n--- Test %s Cache: Block Size (in bytes) ---", label);

		 block_size_bytes = -1;

		 // First read to warm up cache
		 readMem(base_address, dummy_data, prev_delay);

		 // Try increasing stride values
		 for (stride_bytes = 8; stride_bytes <= 1024; stride_bytes *= 2) begin
			  readMem(base_address + stride_bytes, dummy_data, delay);
			  $display("Stride %4d bytes: delay = %3d", stride_bytes, delay);

			  if (delay >= 70) begin  // Adjust this threshold based on your L1 miss penalty
					block_size_bytes = stride_bytes;
					$display("=> Detected %s cache block size = %0d bytes", label, block_size_bytes);
					break;
			  end
		 end
	endtask


	task test_num_blocks;
		 input int base_address;
		 input string label;
		 input int block_size;
		 input int cycles; 
		 output int num_blocks;

		 int i, delay;
		 
		 logic [7:0][7:0] dummy_data;

		 $display("\n--- Test %s Cache: Num of Block ---", label);


		 for (num_blocks = 1; num_blocks <= 1024; num_blocks *=2) begin
				for (i = 0; i < num_blocks; i++) begin
					readMem(base_address + i * block_size, dummy_data, delay);
				end
				
				readMem(base_address, dummy_data, delay);

				$display("Accessed %0d blocks, re-access delay: %0d", num_blocks, delay);
				
				if (delay > cycles) begin
					num_blocks = num_blocks/2;
					$display("=> Detected %s Cache: Num of Block = %0d blocks", label, num_blocks);
					break;
				end			
				
		 end
	endtask
	
	
	task test_associativity;
		 input string label;
		 input int block_size;
		 input int set_conflict_stride;  // large enough to map to same set, but different tags
		 output int associativity;

		 int i, delay;
		 logic [7:0][7:0] read_data;
		 logic [7:0][7:0] write_data;

		 $display("\n--- Test %s Cache: Associativity ---", label);

		 for (associativity = 1; associativity <= 32; associativity++) begin
			  // Fill cache set with conflicting blocks
			  for (i = 0; i < associativity; i++) begin
					write_data = '0;
					write_data[0] = (i == 0) ? 99 : i;   // Unique value for each address
					writeMem(i * set_conflict_stride, write_data, 8'hFF, delay);
			  end

			  // Re-access first address and see if it's evicted
			  readMem(0, read_data, delay);

			  $display("Accessed %0d conflicting blocks, re-access delay: %0d, data = %0d", associativity, delay, read_data[0]);

			  if (read_data[0] != 99) begin
					$display("=> Detected %s Cache: Associativity = %0d-way", label, associativity);
					break;
			  end
		 end
	endtask

	
	

	
	logic	[DATA_WIDTH-1:0][7:0]	dummy_data;
	logic [ADDRESS_WIDTH-1:0]		addr;
	int	i, delay, minval, maxval;
	int l1_block, l2_block, l3_block;
	int l1_num_block, l2_num_block, l3_num_block;
	int l1_associativity, l2_associativity, l3_associativity;
	
	initial begin
		dummy_data <= '0;
		resetMem();				// Initialize the memory.
		
		// Do 20 random reads.
		for (i=0; i<20; i++) begin
			addr = $random()*8; // *8 to doubleword-align the access.
			readMem(addr, dummy_data, delay);
			$display("%t Read took %d cycles", $time, delay);
		end
		
		// Do 5 random double-word writes of random data.
		for (i=0; i<5; i++) begin
			addr = $random()*8; // *8 to doubleword-align the access.
			dummy_data = $random();
			writeMem(addr, dummy_data, 8'hFF, delay);
			$display("%t Write took %d cycles", $time, delay);
		end
		
		// Reset the memory.
		resetMem();
		
		test_block_size_words(0, "L1", l1_block);

		// Force L1 eviction to expose L2
		resetMem();

		test_block_size_words(0, "L2", l2_block);

		// Force L2 eviction to expose L3
		resetMem();
//
//		test_block_size_words(0, "L3", l3_block);
		
		resetMem();

		// Testing of number of blocks 
		test_num_blocks(0, "L1", l1_block, 2, l1_num_block); 
		
		resetMem();

		test_num_blocks(0, "L2", l2_block, 10, l2_num_block);
		
//		resetMem();
//		
////		test_num_blocks(0, "L3", l3_block, 49, l3_num_block);
//		
		resetMem();
		
		// Testing Associativity
		
		test_associativity( "L1", l1_block, l1_block*64, l1_associativity);
		
		resetMem();
		
		test_associativity( "L2", l2_block, l2_block*64, l2_associativity);
		
		resetMem();
//		
////		test_associativity( "L3", l3_block, l3_num_block, l1_associativity);
//		
		$stop();
	end
	
endmodule
