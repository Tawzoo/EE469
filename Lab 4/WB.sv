`timescale 1ps / 1ps
module WB (PC_BL, ALU_Result, DM_Read_Data, MemtoReg, BrLink, Write_Data, clk, reset);
					
	input logic MemtoReg, BrLink, reset, clk;
	input logic [63:0] PC_BL, DM_Read_Data, ALU_Result;
	
	output logic [63:0] Write_Data;

	//4:1 mux
	mux4_1_64 mux1(.i0(ALU_Result), .i1(DM_Read_Data), .i2(PC_BL), .i3(64'bx), .sel({BrLink, MemtoReg}), .out(Write_Data));
	
endmodule 
