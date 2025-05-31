`timescale 1ps / 1ps
module Pipelined_CPU(clk, reset);
	input logic clk, reset;
	
	// Control Signals 
	logic BrTaken, EX_BrTaken, MEM_BrTaken, IF_ID_en, SetFlag, ID_EX_SetFlag, EX_SetFlag, EX_MEM_SetFlag, MemRead, ID_EX_MemRead, EX_MemRead, EX_MEM_MemRead;
	logic MemtoReg, ID_EX_MemtoReg, EX_MemtoReg, EX_MEM_MemtoReg, MEM_MemtoReg, MEM_WB_MemtoReg, MemWrite, ID_EX_MemWrite, EX_MemWrite, EX_MEM_MemWrite;
	logic RegWrite, ID_EX_RegWrite, EX_RegWrite, EX_MEM_RegWrite, MEM_RegWrite, BrLink, ID_EX_BrLink, EX_BrLink, EX_MEM_BrLink, MEM_BrLink, MEM_WB_BRLink;
	logic WB_en, ID_EX_WB_en, EX_WB_en, EX_MEM_WB_en, MEM_WB_en, Mem_en, ID_EX_Mem_en, EX_Mem_en, EX_en, MEM_WB_RegWrite;
	logic negative_out, zero_out, carry_out_out, overflow_out, forwardC;
	logic [1:0] ALUSrc, ID_EX_ALUSrc;
	logic [2:0] ALUOp, ID_EX_ALUOp;
	logic [4:0] ID_Rn, ID_RM, EX_Rd, EX_MEM_Rd, MEM_Rd, MEM_WB_Rd;         
	
	// Address 
	logic [63:0] BrTakenAddr, PC_Addr, IF_PC_Addr, ID_PC_Addr, PC_BL, IF_PC_BL, ID_PC_BL, ID_EX_PC_BL, EX_PC_BL, EX_MEM_PC_BL, MEM_PC_BL, MEM_WB_PC_BL;
	logic [63:0] Read_data1, ID_EX_Read_data1, Read_data2, ID_EX_Read_data2, ALU_FF, EX_MEM_ALU_FF, Imm12Ext, ID_EX_Imm12Ext, Imm9Ext, ID_EX_Imm9Ext;
	logic [63:0] EX_ALU_Result, EX_MEM_ALU_Result, MEM_ALU_Result, MEM_WB_ALU_Result, DM_Read_Data, Write_Data, WB_Write_Data, MEM_WB_DM_Read_Data;
	logic [31:0] instruction, IF_instruction, ID_EX_instruction, ID_instruction;
	logic [3:0] EX_MEM_setflags, ALU_flags, Reg_flags;
	
	assign ID_Rn = ID_EX_instruction[9:5];
	assign ID_RM = ID_EX_instruction[20:16];
	
	// Instruction Fetch (Done)
	Instruction_Fetch IF (.clk(clk), .reset(reset), .BrTaken(BrTaken), .BrTakenAddr(BrTakenAddr), .PC_Addr(PC_Addr), .PC_BL(PC_BL), .instruction(instruction));
	
	// IF/ID registor (Done)
	IF_ID IFID (.IF_ID_en(IF_ID_en), .reset(reset), .clk(clk), .PC_Addr_in(PC_Addr), .PC_Addr_out(IF_PC_Addr), .PC_BL_in(PC_BL), .PC_BL_out(IF_PC_BL), .Instruction_in(instruction), .Instruction_out(IF_instruction));
	
	// Instruction Decoder (Done)
	Instruction_Decoder ID (.clk(clk), .reset(reset), .MEM_WB_BrLink(MEM_WB_BRLink), .MEM_WB_RegWrite(MEM_WB_RegWrite), .EX_MEM_setflags(Reg_flags), .ALU_flags(ALU_flags), .ALU_SetFlag(EX_SetFlag), 
									 .MEM_WB_Rd(MEM_WB_Rd), .PC_Addr_in(IF_PC_Addr), .PC_BL_in(IF_PC_BL), .MEM_WB_write_data(Write_Data), .instruction_in(IF_instruction), .BrTaken(BrTaken),
									 .IF_ID_en(IF_ID_en), .SetFlag(SetFlag), .MemRead(MemRead), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .RegWrite(RegWrite), .BrLink(BrLink), .WB_en(WB_en), .Mem_en(Mem_en), .EX_en(EX_en),
									 .ALUSrc(ALUSrc), .ALUOp(ALUOp), .BrTakenAddr(BrTakenAddr), .PC_Addr_out(ID_PC_Addr), .PC_BL_out(ID_PC_BL), .Read_data1(Read_data1), .Read_data2(Read_data2), .Imm12Ext(Imm12Ext), 
									 .Imm9Ext(Imm9Ext), .instruction_out(ID_instruction)); // Gotta Test
	
	
	// ID/EX Registor (Not Done)
	ID_EX ID_reg (.WB_en_in(WB_en), .WB_en_out(ID_EX_WB_en), .MEM_en_in(Mem_en), .MEM_en_out(ID_EX_Mem_en), .EX_en_in(EX_en), 
				  .PC_BL_in(ID_PC_BL), .PC_BL_out(ID_EX_PC_BL), .Read_data1_in(Read_data1), .Read_data1_out(ID_EX_Read_data1), 
				  .Read_data2_in(Read_data2), .Read_data2_out(ID_EX_Read_data2), .Imm9Ext_in(Imm9Ext), .Imm9Ext_out(ID_EX_Imm9Ext), .Imm12Ext_in(Imm12Ext), .Imm12Ext_out(ID_EX_Imm12Ext), 
				  .Instruction_in(ID_instruction), .Instruction_out(ID_EX_instruction), .SetFlag_in(SetFlag), .SetFlag_out(ID_EX_SetFlag), .ALUOp_in(ALUOp), .BrTaken_in(BrTaken), .BrTaken_out(EX_BrTaken),
				  .ALUOp_out(ID_EX_ALUOp), .MemRead_in(MemRead), .MemtoReg_in(MemtoReg), .MemWrite_in(MemWrite), .RegWrite_in(RegWrite), .BrLink_in(BrLink), .ALUSrc_in(ALUSrc), 
				  .MemRead_out(ID_EX_MemRead), .MemtoReg_out(ID_EX_MemtoReg), .MemWrite_out(ID_EX_MemWrite), .RegWrite_out(ID_EX_RegWrite), .BrLink_out(ID_EX_BrLink), .ALUSrc_out(ID_EX_ALUSrc), .reset(reset), .clk(clk));
	
	// Execution (Done) (Read_Data2_out-> ALU_FF)
	EX Execution (.WB_en_in(ID_EX_WB_en), .MEM_en_in(ID_EX_Mem_en), .reset(reset), .clk(clk), .SetFlag_in(ID_EX_SetFlag), .MemRead_in(ID_EX_MemRead), 
				.MemtoReg_in(ID_EX_MemtoReg), .MemWrite_in(ID_EX_MemWrite), .RegWrite_in(ID_EX_RegWrite), .BrLink_in(ID_EX_BrLink), .EX_RegWrite(EX_MEM_RegWrite), .MEM_WB_BRLink(MEM_WB_BRLink), .MEM_RegWrite(MEM_WB_RegWrite),
				.ID_Rn(ID_Rn), .ID_Rm(ID_RM), .EX_Rd(EX_Rd), /*Ex_Rd = ID_EX_instruction[4:0]*/ .MEM_WB_Rd(MEM_WB_Rd), .Read_Data1(ID_EX_Read_data1), .Read_Data2(ID_EX_Read_data2), .PC_BL_in(ID_EX_PC_BL), .Imm9Ext(ID_EX_Imm9Ext), .Imm12Ext(ID_EX_Imm12Ext), .MEM_ALUResult(MEM_ALU_Result), .MEM_WB_ALUResult(Write_Data), .ALUSrc(ID_EX_ALUSrc), .ALUOp(ID_EX_ALUOp),
				.instruction_in(ID_EX_instruction), .SetFlag_out(EX_SetFlag), .MemRead_out(EX_MemRead), .MemtoReg_out(EX_MemtoReg), .MemWrite_out(EX_MemWrite), .RegWrite_out(EX_RegWrite), .BrLink_out(EX_BrLink), .WB_en_out(EX_WB_en), .MEM_en_out(EX_Mem_en),
				.PC_BL_out(EX_PC_BL), .Read_Data2_out(ALU_FF), .EX_ALU_Result(EX_ALU_Result), .ALU_Flags(ALU_flags), .Reg_Flags(Reg_flags), .EX_MEM_Rd(EX_MEM_Rd), .MEM_WB_PC_BL(MEM_WB_PC_BL), .forwardC(forwardC), .MEM_MemWrite(EX_MEM_MemWrite));
	
	
	// EX/MEM Registor (Done) Read_Data2_out-> ALU_FF
	EX_MEM EX_reg (.MEM_en_in(EX_Mem_en), .WB_en_in(EX_WB_en), .WB_en_out(EX_MEM_WB_en), .PC_BL_in(EX_PC_BL), .PC_BL_out(EX_MEM_PC_BL), .Set_Flags(Reg_flags), .EX_MEM_Set_Flags(EX_MEM_setflags), 
					.ALU_Result_in(EX_ALU_Result), .ALU_Result_out(EX_MEM_ALU_Result), .ALU_FF_in(ALU_FF), .ALU_FF_out(EX_MEM_ALU_FF), .Instruction4_0(EX_Rd), .EX_MEM_Rd(EX_MEM_Rd), /*Ex_Rd -> Ex_MEM_Rd */
					.BrTaken_in(EX_BrTaken), .MemRead_in(EX_MemRead), .MemtoReg_in(EX_MemtoReg), .MemWrite_in(EX_MemWrite), .RegWrite_in(EX_RegWrite), .BrLink_in(EX_BrLink), .negative_in(Reg_flags[0]), .zero_in(Reg_flags[2]), .overflow_in(Reg_flags[1]), .carry_out_in(Reg_flags[3]),
					.BrTaken_out(MEM_BrTaken), .MemRead_out(EX_MEM_MemRead), .MemtoReg_out(EX_MEM_MemtoReg), .MemWrite_out(EX_MEM_MemWrite), .RegWrite_out(EX_MEM_RegWrite), .BrLink_out(EX_MEM_BrLink), .negative_out(negative_out), .zero_out(zero_out), .overflow_out(overflow_out), .carry_out_out(carry_out_out),	
					.clk(clk), .reset);
	// MEM (Done)
	MEM Memory (.WB_en_in(EX_MEM_WB_en), .WB_en_out(MEM_WB_en), .MemRead(EX_MEM_MemRead), .MemWrite(EX_MEM_MemWrite), .BrLink_in(EX_MEM_BrLink), .BrLink_out(MEM_BrLink), .MemtoReg_in(EX_MEM_MemtoReg), .MemtoReg_out(MEM_MemtoReg),
				.PC_BL_in(EX_MEM_PC_BL), .PC_BL_out(MEM_PC_BL), .ALU_Result_in(EX_MEM_ALU_Result), /*.ALU_Result_out(MEM_ALU_Result),*/ .ALU_FF(EX_MEM_ALU_FF), .DM_Read_Data(DM_Read_Data), .Instruction4_0_in(EX_MEM_Rd),
				.MEM_Rd(MEM_Rd), .MEM_ALU_Result(MEM_ALU_Result), .RegWrite_in(EX_MEM_RegWrite), .RegWrite_out(MEM_RegWrite), .clk(clk), .reset(reset), .forwardC(forwardC), .WB_Write_Data(Write_Data)); 
				
	
	// MEM/WB Registor (Done)
	MEM_WB MEM_reg (.WB_en_in(MEM_WB_en), .PC_BL_in(MEM_PC_BL), .PC_BL_out(MEM_WB_PC_BL), .ALU_Result_in(MEM_ALU_Result), .ALU_Result_out(MEM_WB_ALU_Result), .RegWrite_in(MEM_RegWrite), .RegWrite_out(MEM_WB_RegWrite),
					.Instruction4_0(MEM_Rd), .MEM_WB_Rd(MEM_WB_Rd), .DM_Read_Data_in(DM_Read_Data), .DM_Read_Data_out(MEM_WB_DM_Read_Data), 
					.MemtoReg_in(MEM_MemtoReg), .BrLink_in(MEM_BrLink), .MemtoReg_out(MEM_WB_MemtoReg), .BrLink_out(MEM_WB_BRLink), .clk(clk), .reset(reset));
	
	// WB (Done)
	 WB WriteBack (.PC_BL(MEM_WB_PC_BL), .ALU_Result(MEM_WB_ALU_Result), .DM_Read_Data(MEM_WB_DM_Read_Data), .MemtoReg(MEM_WB_MemtoReg), .BrLink(MEM_WB_BRLink), .Write_Data(Write_Data), .clk(clk), .reset(reset));
	
	
			
endmodule 

module Pipelined_CPU_testbench();
	logic clk, reset;
	
	Pipelined_CPU dut (.*);
	
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
		
		for (i = 0; i < 300; i++) begin
			@(posedge clk);
		end
		$stop;
	end	
endmodule