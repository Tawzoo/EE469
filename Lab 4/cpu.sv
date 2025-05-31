`timescale 1ps / 1ps
module cpu(clk, reset);
	input logic clk, reset;
	
	
	// Instruction Fetch
	
	// IF/ID registor
	
	// Instruction Decoder (Control Signals, Hazard Unit, 32 Registers)
	
	// Control Unit
	
	// Hazard Unit 
	
	// ID/EX Registor
	
	// Execution 
	
	// Forwarding Unit
	
	// EX/MEM Registor
	
	// MEM 
	
	// MEM/WB Registor
	
	// WB 
	
	
	
//	logic [63:0] pc, alusrc_mux_out, dp_writedata, alu_result, read_data2, dm_read_data;
//	logic [31:0] instruction;
//	logic mem_read, mem_write;
	
	//should connect instruction mem, datapath, and data memory
	// instructmem instruction_memory(.address(pc), .instruction(instruction), .clk(clk));
	// datapath datapath1(.pc_out(pc), .read_data2(read_data2), .alu_result(alu_result), .instr(instruction), .dm_read_data(dm_read_data), .dm_mem_write(mem_write), .dm_mem_read(mem_read), .clk(clk), .reset(reset));
	// datamem datamemory(.address(alu_result), .write_enable(mem_write), .read_enable(mem_read), .write_data(read_data2), .clk(clk), .xfer_size(4'd8), .read_data(dm_read_data));
		
endmodule 

module cpu_testbench();
	logic clk, reset;
	
	cpu dut (.*);
	
	parameter CLOCK_PERIOD = 10000;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	int i;
	initial begin
		reset <= 1; 
			repeat(4) @(posedge clk);
		reset <= 0; 
		
		for (i = 0; i < 400; i++) begin
			@(posedge clk);
		end
		$stop;
	end	
endmodule