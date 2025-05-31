`timescale 1ps / 1ps
module Instruction_Fetch (clk, reset, BrTaken, BrTakenAddr, PC_Addr, PC_BL, instruction); // Gotta Test
	input logic clk, reset, BrTaken;
	input logic [63:0] BrTakenAddr;
	output logic [63:0] PC_Addr, PC_BL;
	output logic [31:0] instruction; 
	
	logic [63:0] PC_in, PC_norm; 
	
	assign PC_BL = PC_norm;
	
	mux2_1_64bit branch_mux (.i0(PC_norm), .i1(BrTakenAddr), .sel(BrTaken), .out(PC_in)); //Branch Address Mux
	
	fullAdder64 pc_adder0(.A(PC_Addr), .B(64'd4), .out(PC_norm), .carryout(), .overflow()); //PC Adder (PC = PC + 4)
	
	// Made the pc with write enable for stalling, stall_PC is flipped so we don't write when stall_PC = 1
	pc program_counter(.reset(reset), .clk(clk), .wrt_en(1'b1), .datain(PC_in), .dataout(PC_Addr)); //PC 
	
	instructmem instruction_memory(.address(PC_Addr), .instruction(instruction), .clk(clk)); // Insturction Memory
	

endmodule 

module Instruction_Fetch_tb();
	logic clk, reset, BrTaken;
	logic [63:0] BrTakenAddr;
	logic [63:0] PC_Addr, PC_BL;
	logic [31:0] instruction;

	Instruction_Fetch dut (.*);
	
	parameter CLOCK_PERIOD = 10000;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
		// Initialize signals
		reset = 1;
		BrTaken = 0;
		BrTakenAddr = 64'h0000_0000_0000_0010;

		// Hold reset for a few cycles
		repeat (2) @(posedge clk);
		reset = 0;

		// Run normally for a few cycles
		repeat (5) @(posedge clk);

		// Trigger a branch
		BrTaken = 1;
		@(posedge clk);

		// Disable branch
		BrTaken = 0;
		repeat (5) @(posedge clk);

		$display("Finished Instruction Fetch Test");
		$stop;
	end	
endmodule