`timescale 1ps / 1ps
module Instruction_Decoder (clk, reset, MEM_WB_BrLink, MEM_WB_RegWrite, EX_MEM_setflags, ALU_flags, ALU_SetFlag, 
									 MEM_WB_Rd, PC_Addr_in, PC_BL_in, MEM_WB_write_data, instruction_in, BrTaken,
									 IF_ID_en, SetFlag, MemRead, MemtoReg, MemWrite, RegWrite, BrLink, WB_en, Mem_en, EX_en,
									 ALUSrc, ALUOp, BrTakenAddr, PC_Addr_out, PC_BL_out, Read_data1, Read_data2, Imm12Ext, 
									 Imm9Ext, instruction_out); // Gotta Test


	input logic clk, reset, MEM_WB_BrLink, MEM_WB_RegWrite, ALU_SetFlag; // Control signals
	input logic [3:0] EX_MEM_setflags, ALU_flags; // Flags 
	input logic [4:0] MEM_WB_Rd; // Write Address 
	input logic [63:0] PC_Addr_in, PC_BL_in, MEM_WB_write_data; // Address & Data
	input logic [31:0] instruction_in; // Instruction
	
	output logic  IF_ID_en, SetFlag, MemRead, MemtoReg, MemWrite, RegWrite, BrLink, WB_en, Mem_en, EX_en, BrTaken; // Control signals out 
	output logic [1:0]  ALUSrc; // Control signals out 
	output logic [2:0]  ALUOp; // ALU op code
	output logic [63:0] BrTakenAddr, PC_Addr_out, PC_BL_out, Read_data1, Read_data2, Imm12Ext, Imm9Ext;  // Data out
	output logic [31:0] instruction_out; // Instruction out 
	
	logic [63:0] Se_Addr, UnCondAddressExt, BRAddressExt,  SHFT_Addr, Br_Added_Addr, reg_clk; // Temporary 64 bit
	logic [4:0] Read_Reg2, wrt_reg, flags; // Temporary read/write address
	logic zero_flg, overflag, negflag, reg2loc, uncondbranch, br2reg;
	
	assign instruction_out = instruction_in;
	assign PC_Addr_out = PC_Addr_in;
	assign PC_BL_out = PC_BL_in;
	
	// PC address based on Branching 
	sign_ext #(.IN_WIDTH(19)) UNCOND_extender(.in(instruction_in[23:5]), .out(UnCondAddressExt)); // Sign Extender for CBZ
	sign_ext #(.IN_WIDTH(26)) BR_extender(.in(instruction_in[25:0]), .out(BRAddressExt)); // Sign Extender for B
	mux2_1_64bit branch_mux1 (.i0(UnCondAddressExt), .i1(BRAddressExt), .sel(uncondbranch), .out(Se_Addr)); //Branch Address Mux
	assign SHFT_Addr = {Se_Addr[61:0], 2'b0}; //Shifter
	
	
	fullAdder64 pc_adder1(.A(PC_Addr_in), .B(SHFT_Addr), .out(Br_Added_Addr), .carryout(), .overflow()); //PC Adder 1
	mux2_1_64bit branch_mux2 (.i0(Br_Added_Addr), .i1(Read_data2), .sel(br2reg), .out(BrTakenAddr)); //Branch vs BR Address Mux
	
	// Immediates 
	sign_ext #(.IN_WIDTH(9)) Imm9_extender(.in(instruction_in[20:12]), .out(Imm9Ext)); // Sign Extender for LDUR
	zero_ext #(.IN_WIDTH(12)) ADDI_extender(.in(instruction_in[21:10]), .out(Imm12Ext)); // Zero Extender for ADDI
	
	
	
	// Control Unit																						
	control_unit controlUnit(.opcode(instruction_in[31:21]), .negflag(negflag), .zeroflag(zero_flg), .overflag(overflag), .ALUOp(ALUOp), .SetFlag(SetFlag), 
									 .Reg2Loc(reg2loc), .Uncondbranch(uncondbranch), .BrTaken(BrTaken), .MemRead(MemRead), .MemtoReg(MemtoReg), 
								    .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .BrtoReg(br2reg), .BrLink(BrLink),
									 .IF_en(IF_ID_en), .WB_en(WB_en), .Mem_en(Mem_en), .EX_en(EX_en));
	
   // Flags	
	//zeroCheck z_check  (.check(Read_data2), .zeroRes(zero_flg)); 
	
	mux2_1_5bit flag_mux (.i1({1'b0,ALU_flags}), .i0({1'b0,EX_MEM_setflags}), .sel(ALU_SetFlag), .out(flags)); 
	assign negflag = flags[3];
	assign overflag = flags[2]; 
	assign zero_flg = ALU_flags[1];
	
	
	//mux4_1_64 branch_mux (.i0(read_data2), .i1(DM_Read_Data), .i2(EX_ALU_Result), .i3(64'bx), .sel(forwardA), .out(alusrc_mux_out));
	
	// 32 Registers
	mux2_1_5bit reg2loc_mux (.i0(instruction_in[4:0]), .i1(instruction_in[20:16]), .sel(reg2loc), .out(Read_Reg2)); //Reg2Loc mux
	
	mux2_1_5bit reg_mux (.i0(MEM_WB_Rd), .i1(5'd30), .sel(MEM_WB_BrLink), .out(wrt_reg)); //Write Address Mux
	
	regfile registers (.ReadData1(Read_data1), .ReadData2(Read_data2), .WriteData(MEM_WB_write_data), .ReadRegister1(instruction_in[9:5]), 
							 .ReadRegister2(Read_Reg2), .WriteRegister(wrt_reg), .RegWrite(MEM_WB_RegWrite), .clk(~clk)); //Registers
	
//	not #50 not_Gate(reg_clk, clk); 
								
endmodule 

module Instruction_Decoder_tb();
//	logic clk, reset;
//	
//	cpu dut (.*);
//	
//	parameter CLOCK_PERIOD = 10000;
//	initial begin
//		clk <= 0;
//		forever #(CLOCK_PERIOD/2) clk <= ~clk;
//	end
//	
//	int i;
//	initial begin
//		reset <= 1; 
//			repeat(4) @(posedge clk);
//		reset <= 0; 
//		
//		for (i = 0; i < 400; i++) begin
//			@(posedge clk);
//		end
//		$stop;
	//end	
endmodule