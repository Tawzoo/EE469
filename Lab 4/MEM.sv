`timescale 1ps / 1ps
module MEM (WB_en_in, WB_en_out, MemRead, MemWrite, BrLink_in, BrLink_out, MemtoReg_in, MemtoReg_out,
				PC_BL_in, PC_BL_out, ALU_Result_in, /*ALU_Result_out,*/ ALU_FF, DM_Read_Data, Instruction4_0_in,
				MEM_Rd, MEM_ALU_Result, RegWrite_in, RegWrite_out, clk, reset, forwardC, WB_Write_Data); // Need to finish this 
					
	input logic WB_en_in, MemRead, MemWrite, RegWrite_in, BrLink_in, MemtoReg_in, reset, clk, forwardC;
	input logic [63:0] PC_BL_in, ALU_Result_in, ALU_FF, WB_Write_Data;
	input logic [4:0] Instruction4_0_in;
	
	output logic WB_en_out, BrLink_out, MemtoReg_out, RegWrite_out;
	output logic [63:0] PC_BL_out, /*ALU_Result_out,*/ DM_Read_Data, MEM_ALU_Result;
	output logic [4:0] MEM_Rd;
	
	logic [63:0] DM_Write_Data;
	
	mux2_1_64bit write_mux (.i0(ALU_FF), .i1(WB_Write_Data), .sel(forwardC), .out(DM_Write_Data)); //Branch vs BR Address Mux

	
	//Data Memory
	datamem datamemory(.address(ALU_Result_in), .write_enable(MemWrite), .read_enable(MemRead), .write_data(DM_Write_Data), 
							 .clk(clk), .xfer_size(4'd8), .read_data(DM_Read_Data));
							 
	assign WB_en_out = WB_en_in;
	assign BrLink_out = BrLink_in;
	assign MemtoReg_out = MemtoReg_in;
	assign PC_BL_out = PC_BL_in;
//	assign ALU_Result_out = ALU_Result_in;
	assign MEM_ALU_Result = ALU_Result_in;
	assign MEM_Rd = Instruction4_0_in;
	assign RegWrite_out = RegWrite_in;
	
endmodule
	
