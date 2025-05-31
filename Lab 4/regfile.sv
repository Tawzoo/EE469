`timescale 1ps / 1ps
module regfile(ReadData1, ReadData2, WriteData, ReadRegister1, 
					ReadRegister2, WriteRegister,RegWrite, clk);
					
	output logic [63:0] ReadData1, ReadData2;
	input  logic [63:0] WriteData;
	input  logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input  logic RegWrite, clk;
	
	logic [63:0] register_32 [31:0]; 
	logic [31:0] sel; 
	
	//decoder
	decoder5_32 decoder5_32_1 (.i0(WriteRegister[0]), .i1(WriteRegister[1]), .i2(WriteRegister[2]), .i3(WriteRegister[3]), .i4(WriteRegister[4]), .en(RegWrite), .out(sel));
	
	//registers
	genvar i;
	generate
		for(i = 0; i< 31; i++) begin : eachreg
			register regs (.wrt_en(sel[i]), .reset(1'b0), .clk(clk), .datain(WriteData), .dataout(register_32[i]));

		end
	endgenerate 
	
	assign register_32[31] = 64'b0;
	
	// Declare temp wires for mux output (added)
	//logic [63:0] read_data1_temp, read_data2_temp;

	// Mux output to temp wires
	mux32_64 mux32_64_1 (.in(register_32), .sel(ReadRegister1), .out(ReadData1)); //changed to temp
	mux32_64 mux32_64_2 (.in(register_32), .sel(ReadRegister2), .out(ReadData2)); //changed to temp

	// Final outputs with write-before-read logic (added)
	//assign ReadData1 = (RegWrite && (WriteRegister == ReadRegister1) && (WriteRegister != 5'd31)) ? WriteData : read_data1_temp;
   //assign ReadData2 = (RegWrite && (WriteRegister == ReadRegister2) && (WriteRegister != 5'd31)) ? WriteData : read_data2_temp;
		
	endmodule 

module regfile_testbench ();
	logic [63:0] ReadData1, ReadData2;
	logic [63:0] WriteData;
	logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	logic RegWrite, clk; 
	
	integer i;
	
	regfile dut (.*);
	
	parameter clk_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(clk_PERIOD / 2) clk <= ~clk; // Clock toggle
	end

	initial begin
		// Try to write the value 0xA0 into register 31.
		// Register 31 should always be at the value of 0.
		RegWrite <= 5'd0;
		ReadRegister1 <= 5'd0;
		ReadRegister2 <= 5'd0;
		WriteRegister <= 5'd31;
		WriteData <= 64'h00000000000000A0;
		@(posedge clk);
		
		$display("%t Attempting overwrite of register 31, which should always be 0", $time);
		RegWrite <= 1;
		@(posedge clk);

		// Write a value into each  register.
		$display("%t Writing pattern to all registers.", $time);
		
		for (i=0; i<31; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000010204080001;
			@(posedge clk);
			
			RegWrite <= 1;
			@(posedge clk);
		end

		// Go back and verify that the registers
		// retained the data.
		$display("%t Checking pattern.", $time);
		for (i=0; i<32; i=i+1) begin
			RegWrite <= 0;
			ReadRegister1 <= i-1;
			ReadRegister2 <= i;
			WriteRegister <= i;
			WriteData <= i*64'h0000000000000100+i;
			@(posedge clk);
		end
		$stop;
	end


endmodule 