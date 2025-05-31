`timescale 1ps / 1ps
module ID_EX (WB_en_in, WB_en_out, MEM_en_in, MEM_en_out, EX_en_in, 
				  PC_BL_in, PC_BL_out, Read_data1_in, Read_data1_out, 
				  Read_data2_in, Read_data2_out, Imm9Ext_in, Imm9Ext_out, Imm12Ext_in, Imm12Ext_out, 
				  Instruction_in, Instruction_out, SetFlag_in, SetFlag_out, ALUOp_in, 
				  ALUOp_out, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, BrLink_in, ALUSrc_in, BrTaken_in,
				  MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out, BrLink_out, ALUSrc_out, BrTaken_out, reset, clk);
				  
	input logic WB_en_in, MEM_en_in, EX_en_in, SetFlag_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, BrLink_in, BrTaken_in, reset, clk;
	input logic [63:0] PC_BL_in, Read_data1_in, Read_data2_in, Imm9Ext_in, Imm12Ext_in;
	input logic [31:0] Instruction_in;
	input logic [1:0] ALUSrc_in;
	input logic [2:0] ALUOp_in;
	
	output logic WB_en_out, MEM_en_out, SetFlag_out, MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out, BrLink_out, BrTaken_out;
	output logic [63:0] PC_BL_out, Read_data1_out, Read_data2_out, Imm9Ext_out, Imm12Ext_out;
//	output logic [6:0] Instruction9_3;
//	output logic [4:0] Instruction20_16, Instruction4_0;
	output logic [31:0] Instruction_out;
	output logic [2:0] ALUOp_out;
	output logic [1:0] ALUSrc_out;
	
	//PC_Addr, Read_data1, Read_data2, Imm9Ext, Imm12Ext
	genvar i;
	generate
		for(i = 0; i< 64; i++) begin : eachDFF1
			en_reg u_en_reg_1i (.wrt_en(EX_en_in), .datain(PC_BL_in[i]), .reset(reset), .clk(clk), .dataout(PC_BL_out[i]));
			en_reg u_en_reg_2i (.wrt_en(EX_en_in), .datain(Read_data1_in[i]), .reset(reset), .clk(clk), .dataout(Read_data1_out[i]));
			en_reg u_en_reg_3i (.wrt_en(EX_en_in), .datain(Read_data2_in[i]), .reset(reset), .clk(clk), .dataout(Read_data2_out[i]));
			en_reg u_en_reg_4i (.wrt_en(EX_en_in), .datain(Imm9Ext_in[i]), .reset(reset), .clk(clk), .dataout(Imm9Ext_out[i]));
			en_reg u_en_reg_5i (.wrt_en(EX_en_in), .datain(Imm12Ext_in[i]), .reset(reset), .clk(clk), .dataout(Imm12Ext_out[i]));
		end
	endgenerate 
	
	//Instruction9_3
	genvar j;
	generate
		for(j = 0; j< 32; j++) begin : eachDFF2
			en_reg u_en_reg_6i (.wrt_en(EX_en_in), .datain(Instruction_in[j]), .reset(reset), .clk(clk), .dataout(Instruction_out[j]));
		end
	endgenerate 
	
	//Instruction20_16, Instruction4_0
//	genvar k;
//	generate
//		for(k = 0; k< 5; k++) begin : eachDFF3
//			en_reg u_en_reg_7i (.wrt_en(EX_en_in), .datain(Instruction_in[i+16]), .reset(reset), .clk(clk), .dataout(Instruction20_16[i]));
//			en_reg u_en_reg_8i (.wrt_en(EX_en_in), .datain(Instruction_in[i]), .reset(reset), .clk(clk), .dataout(Instruction4_0[i]));
//		end
//	endgenerate 
	genvar k;
	generate
		for(k = 0; k< 3; k++) begin : eachDFF3
			en_reg u_en_reg_6i (.wrt_en(EX_en_in), .datain(ALUOp_in[k]), .reset(reset), .clk(clk), .dataout(ALUOp_out[k]));
		end
	endgenerate 


	//WB_en
	en_reg u_en_reg_9 (.wrt_en(EX_en_in), .datain(WB_en_in), .reset(reset), .clk(clk), .dataout(WB_en_out));
	//MEM_en
	en_reg u_en_reg_10 (.wrt_en(EX_en_in), .datain(MEM_en_in), .reset(reset), .clk(clk), .dataout(MEM_en_out));
	
	//Control Signals
	//SetFlag, BrTaken, MemRead, MemtoReg, MemWrite, RegWrite, BrLink, ALUSrc
	en_reg u_en_reg_11 (.wrt_en(EX_en_in), .datain(SetFlag_in), .reset(reset), .clk(clk), .dataout(SetFlag_out));
   en_reg u_en_reg_12 (.wrt_en(EX_en_in), .datain(BrTaken_in), .reset(reset), .clk(clk), .dataout(BrTaken_out));
	en_reg u_en_reg_13 (.wrt_en(EX_en_in), .datain(MemRead_in), .reset(reset), .clk(clk), .dataout(MemRead_out));
	en_reg u_en_reg_14 (.wrt_en(EX_en_in), .datain(MemtoReg_in), .reset(reset), .clk(clk), .dataout(MemtoReg_out));
	en_reg u_en_reg_15 (.wrt_en(EX_en_in), .datain(MemWrite_in), .reset(reset), .clk(clk), .dataout(MemWrite_out));
	en_reg u_en_reg_16 (.wrt_en(EX_en_in), .datain(RegWrite_in), .reset(reset), .clk(clk), .dataout(RegWrite_out));
	en_reg u_en_reg_17 (.wrt_en(EX_en_in), .datain(BrLink_in), .reset(reset), .clk(clk), .dataout(BrLink_out));
	en_reg u_en_reg_18 (.wrt_en(EX_en_in), .datain(ALUSrc_in[0]), .reset(reset), .clk(clk), .dataout(ALUSrc_out[0]));
	en_reg u_en_reg_19 (.wrt_en(EX_en_in), .datain(ALUSrc_in[1]), .reset(reset), .clk(clk), .dataout(ALUSrc_out[1]));

endmodule 

module ID_EX_tb();
	logic WB_en_in, MEM_en_in, EX_en_in, SetFlag_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, BrLink_in, BrTaken_in, reset, clk;
	logic [63:0] PC_BL_in, Read_data1_in, Read_data2_in, Imm9Ext_in, Imm12Ext_in;
	logic [31:0] Instruction_in;
	logic [1:0] ALUSrc_in;
	logic [2:0] ALUOp_in;
	
	logic WB_en_out, MEM_en_out, SetFlag_out, MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out, BrLink_out, BrTaken_out;
	logic [63:0] PC_BL_out, Read_data1_out, Read_data2_out, Imm9Ext_out, Imm12Ext_out;
//	logic [6:0] Instruction9_3;
//	logic [4:0] Instruction20_16, Instruction4_0;
	logic [31:0] Instruction_out;
	logic [2:0] ALUOp_out;
	logic [1:0] ALUSrc_out;

	ID_EX dut (.*);
	
	parameter CLOCK_PERIOD = 10000;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin

		 // Initial reset
		 reset = 1;
		 EX_en_in = 0;
		 WB_en_in = 1;
		 MEM_en_in = 1;
		 SetFlag_in = 1;
		 MemRead_in = 0;
		 MemtoReg_in = 1;
		 MemWrite_in = 1;
		 RegWrite_in = 1;
		 BrLink_in = 0;
		 ALUSrc_in = 2'b10;
		 ALUOp_in = 3'b101;
		 PC_BL_in = 64'h1111_2222_3333_4444;
		 Read_data1_in = 64'hAAAA_AAAA_AAAA_AAAA;
		 Read_data2_in = 64'hBBBB_BBBB_BBBB_BBBB;
		 Imm9Ext_in = 64'h0000_0000_0000_0099;
		 Imm12Ext_in = 64'h0000_0000_0000_0ABC;
		 Instruction_in = 32'hDEADBEEF;
		 #10000;

		 reset = 0;
		 EX_en_in = 1;
		 #10000;

		 // Change input but disable write
		 EX_en_in = 0;
		 PC_BL_in = 64'h5555_5555_5555_5555;
		 Instruction_in = 32'hCAFEBABE;
		 ALUOp_in = 3'b000;
		 #10000;

		 // Enable write again
		 EX_en_in = 1;
		 Instruction_in = 32'h12345678;
		 ALUOp_in = 3'b011;
		 #10000;
		$stop;
	end	
endmodule