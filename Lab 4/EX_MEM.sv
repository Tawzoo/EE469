`timescale 1ps / 1ps
module EX_MEM (MEM_en_in, WB_en_in, WB_en_out, PC_BL_in, PC_BL_out, Set_Flags, EX_MEM_Set_Flags, 
					ALU_Result_in, ALU_Result_out, ALU_FF_in, ALU_FF_out, Instruction4_0, EX_MEM_Rd, 
					BrTaken_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, BrLink_in, negative_in, zero_in, overflow_in, carry_out_in,
					BrTaken_out, MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out, BrLink_out, negative_out, zero_out, overflow_out, carry_out_out,	
					clk, reset);
					
	input logic MEM_en_in, WB_en_in, reset, clk, BrTaken_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, BrLink_in, negative_in, zero_in, overflow_in, carry_out_in;
	input logic [63:0] PC_BL_in, ALU_Result_in, ALU_FF_in;
	input logic [3:0] Set_Flags;
	input logic [4:0] Instruction4_0;
	
	output logic WB_en_out, BrTaken_out, MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out, BrLink_out, negative_out, zero_out, overflow_out, carry_out_out;
	output logic [63:0] PC_BL_out, ALU_Result_out, ALU_FF_out;
	output logic [3:0] EX_MEM_Set_Flags;
	output logic [4:0] EX_MEM_Rd;

	//PC_Addr, ALU_Result, ALU_FF
	genvar i;
	generate
		for(i = 0; i< 64; i++) begin : eachDFF1
			en_reg u_en_reg_1i (.wrt_en(MEM_en_in), .datain(PC_BL_in[i]), .reset(reset), .clk(clk), .dataout(PC_BL_out[i]));
			en_reg u_en_reg_2i (.wrt_en(MEM_en_in), .datain(ALU_Result_in[i]), .reset(reset), .clk(clk), .dataout(ALU_Result_out[i]));
			en_reg u_en_reg_3i (.wrt_en(MEM_en_in), .datain(ALU_FF_in[i]), .reset(reset), .clk(clk), .dataout(ALU_FF_out[i]));
		end
	endgenerate 
	
	//Set_Flags
	genvar j;
	generate
		for(j = 0; j< 4; j++) begin : eachDFF2
			en_reg u_en_reg_4i (.wrt_en(MEM_en_in), .datain(Set_Flags[j]), .reset(reset), .clk(clk), .dataout(EX_MEM_Set_Flags[j]));
		end
	endgenerate 
	
	//Instruction4_0
	genvar k;
	generate
		for(k = 0; k< 5; k++) begin : eachDFF3
			en_reg u_en_reg_5i (.wrt_en(MEM_en_in), .datain(Instruction4_0[k]), .reset(reset), .clk(clk), .dataout(EX_MEM_Rd[k]));
		end
	endgenerate 

	//WB_en
	en_reg u_en_reg_9 (.wrt_en(MEM_en_in), .datain(WB_en_in), .reset(reset), .clk(clk), .dataout(WB_en_out));
	
	//Control Signals
	//BrTaken, MemRead, MemtoReg, MemWrite, RegWrite, BrLink
	en_reg u_en_reg_10 (.wrt_en(MEM_en_in), .datain(BrTaken_in), .reset(reset), .clk(clk), .dataout(BrTaken_out));
	en_reg u_en_reg_11 (.wrt_en(MEM_en_in), .datain(MemRead_in), .reset(reset), .clk(clk), .dataout(MemRead_out));
	en_reg u_en_reg_12 (.wrt_en(MEM_en_in), .datain(MemtoReg_in), .reset(reset), .clk(clk), .dataout(MemtoReg_out));
	en_reg u_en_reg_13 (.wrt_en(MEM_en_in), .datain(MemWrite_in), .reset(reset), .clk(clk), .dataout(MemWrite_out));
	en_reg u_en_reg_14 (.wrt_en(MEM_en_in), .datain(RegWrite_in), .reset(reset), .clk(clk), .dataout(RegWrite_out));
	en_reg u_en_reg_15 (.wrt_en(MEM_en_in), .datain(BrLink_in), .reset(reset), .clk(clk), .dataout(BrLink_out));
	
	//ALU Flags
	//negative, zero, overflow, carry_out
	en_reg u_en_reg_16 (.wrt_en(MEM_en_in), .datain(negative_in), .reset(reset), .clk(clk), .dataout(negative_out));
	en_reg u_en_reg_17 (.wrt_en(MEM_en_in), .datain(zero_in), .reset(reset), .clk(clk), .dataout(zero_out));
	en_reg u_en_reg_18 (.wrt_en(MEM_en_in), .datain(overflow_in), .reset(reset), .clk(clk), .dataout(overflow_out));
	en_reg u_en_reg_19 (.wrt_en(MEM_en_in), .datain(carry_out_in), .reset(reset), .clk(clk), .dataout(carry_out_out));
endmodule

module EX_MEM_tb ();
					
	logic MEM_en_in, WB_en_in, reset, clk, BrTaken_in, MemRead_in, MemtoReg_in, MemWrite_in, RegWrite_in, BrLink_in, negative_in, zero_in, overflow_in, carry_out_in;
	logic [63:0] PC_BL_in, ALU_Result_in, ALU_FF_in;
	logic [3:0] Set_Flags;
	logic [4:0] Instruction4_0;
	
	logic WB_en_out, BrTaken_out, MemRead_out, MemtoReg_out, MemWrite_out, RegWrite_out, BrLink_out, negative_out, zero_out, overflow_out, carry_out_out;
	logic [63:0] PC_BL_out, ALU_Result_out, ALU_FF_out;
	logic [3:0] EX_MEM_Set_Flags;
	logic [4:0] EX_MEM_Rd;

	
	integer i;
	
	EX_MEM dut (.*);
	
	parameter clk_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(clk_PERIOD / 2) clk <= ~clk; // Clock toggle
	end

	initial begin

		 // Initial conditions
		 reset = 1;
		 MEM_en_in = 0;
		 WB_en_in = 0;
		 PC_BL_in = 64'hAAAA_BBBB_CCCC_DDDD;
		 ALU_Result_in = 64'h1234_5678_9ABC_DEF0;
		 ALU_FF_in = 64'h0F0F_0F0F_0F0F_0F0F;
		 Set_Flags = 4'b1010;
		 Instruction4_0 = 5'b11011;
		 BrTaken_in = 1;
		 MemRead_in = 0;
		 MemtoReg_in = 1;
		 MemWrite_in = 1;
		 RegWrite_in = 0;
		 BrLink_in = 1;
		 negative_in = 1;
		 zero_in = 0;
		 overflow_in = 1;
		 carry_out_in = 0;
		 #10000;

		 reset = 0;
		 MEM_en_in = 1;
		 WB_en_in = 1;
		 #10000;


		 // Change inputs but disable write
		 MEM_en_in = 0;
		 PC_BL_in = 64'hDEAD_BEEF_DEAD_BEEF;
		 ALU_Result_in = 64'h1111_2222_3333_4444;
		 ALU_FF_in = 64'h5555_6666_7777_8888;
		 Set_Flags = 4'b0101;
		 Instruction4_0 = 5'b00100;
		 negative_in = 0;
		 zero_in = 1;
		 overflow_in = 0;
		 carry_out_in = 1;
		 #10000;


		 // Enable write again
		 MEM_en_in = 1;
		 #10000;


		 $stop;

	end


endmodule