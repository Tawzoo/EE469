`timescale 1ps / 1ps
module EX (WB_en_in, MEM_en_in, reset, clk, SetFlag_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, BrLink_in, EX_RegWrite, MEM_WB_BRLink, MEM_RegWrite,
				ID_Rn, ID_Rm, EX_Rd, MEM_WB_Rd, Read_Data1, Read_Data2, PC_BL_in, Imm9Ext, Imm12Ext, MEM_ALUResult, MEM_WB_ALUResult, ALUSrc, ALUOp,
				instruction_in, SetFlag_out, MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out, BrLink_out, WB_en_out, MEM_en_out,
				PC_BL_out, Read_Data2_out, EX_ALU_Result, ALU_Flags, Reg_Flags, EX_MEM_Rd, MEM_WB_PC_BL, forwardC, MEM_MemWrite, WB_Write_Data);

					
	input logic WB_en_in, MEM_en_in, reset, clk, SetFlag_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, BrLink_in, EX_RegWrite, MEM_WB_BRLink, MEM_RegWrite, MEM_MemWrite;
	input logic [4:0] ID_Rn, ID_Rm, EX_MEM_Rd, MEM_WB_Rd;
	input logic [63:0] Read_Data1, Read_Data2, PC_BL_in, MEM_WB_PC_BL, Imm9Ext, Imm12Ext, MEM_ALUResult, MEM_WB_ALUResult, WB_Write_Data;
	input logic [1:0]  ALUSrc;
	input logic [2:0]  ALUOp; 
	input logic [31:0] instruction_in;
	
	output logic SetFlag_out, MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out, BrLink_out, WB_en_out, MEM_en_out, forwardC;
	output logic [63:0] PC_BL_out, Read_Data2_out, EX_ALU_Result;
	output logic [3:0] ALU_Flags, Reg_Flags; // ALu_flags and the one that goes into Ex.Mem regsiter
	output logic [4:0] EX_Rd; 
	
	logic [1:0] forwardA, forwardB;
	logic negative, zero, overflow, carryout;
	logic [63:0] ALU_Read_data1, forward_data, ALU_Read_data2, ALU_Result;
	
	// Forwarding 
	Forwarding_Unit fwd (.ID_Rn(instruction_in[9:5]), .ID_Rm(instruction_in[20:16]), .EX_Rd(EX_MEM_Rd), .MEM_Rd(MEM_WB_Rd), .MEM_Rt(instruction_in[4:0]), .EX_RegWrite(EX_RegWrite), 
								.MEM_RegWrite(MEM_RegWrite), .MEM_WB_BRLink(MEM_WB_BRLink), .MEM_MemWrite(MEM_MemWrite),
								.forwardA(forwardA), .forwardB(forwardB), .forwardC(forwardC));
								
	mux2_1_64bit Stur_hazard (.i0(forward_data), .i1(MEM_WB_ALUResult), .sel(forwardC), .out(Read_Data2_out));
								
	
	mux4_1_64 ALU_read1 (.i3(MEM_WB_PC_BL), .i2(MEM_ALUResult), .i1(MEM_WB_ALUResult), .i0(Read_Data1), .sel(forwardA), .out(ALU_Read_data1));
	mux4_1_64 ALU_read2 (.i3(MEM_WB_PC_BL), .i2(MEM_ALUResult), .i1(MEM_WB_ALUResult), .i0(Read_Data2), .sel(forwardB), .out(forward_data));
	
	
	mux4_1_64 alusrc_mux (.i0(forward_data), .i1(Imm12Ext), .i2(Imm9Ext), .i3(64'b0), .sel(ALUSrc), .out(ALU_Read_data2));
	
	
	alu alu1 (.A(ALU_Read_data1), .B(ALU_Read_data2), .cntrl(ALUOp), .result(ALU_Result), .negative(negative), .zero(zero), .overflow(overflow), .carry_out(carryout)); //ALU

	FlagRegister setflags (.reset(reset), .clk(clk), .en(SetFlag_in), .in(ALU_Flags), .out(Reg_Flags));

	
							 
	assign WB_en_out = WB_en_in;
	assign ALU_Flags = {negative, overflow, zero, carryout};
	assign RegWrite_out = RegWrite_in; 
	
	//assign Read_Data2_out = forward_data;
	assign SetFlag_out = SetFlag_in; 
	assign MEM_en_out = MEM_en_in;
	assign MemRead_out = MemRead_in;
	assign MemWrite_out = MemWrite_in;
	assign BrLink_out = BrLink_in;
	assign MemtoReg_out = MemtoReg_in;
	assign PC_BL_out = PC_BL_in;
	assign EX_ALU_Result = ALU_Result;
	assign EX_Rd = instruction_in[4:0];
	
endmodule 