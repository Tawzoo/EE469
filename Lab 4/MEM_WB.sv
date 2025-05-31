`timescale 1ps / 1ps
module MEM_WB (WB_en_in, PC_BL_in, PC_BL_out, ALU_Result_in, ALU_Result_out, RegWrite_in, 
					Instruction4_0, MEM_WB_Rd, DM_Read_Data_in, DM_Read_Data_out, RegWrite_out,
					MemtoReg_in, BrLink_in, MemtoReg_out, BrLink_out, clk, reset);
					
	input logic WB_en_in, MemtoReg_in, BrLink_in, RegWrite_in, reset, clk;
	input logic [63:0] PC_BL_in, DM_Read_Data_in, ALU_Result_in;
	input logic [4:0] Instruction4_0;
	
	output logic MemtoReg_out, BrLink_out, RegWrite_out;
	output logic [63:0] PC_BL_out, DM_Read_Data_out, ALU_Result_out;
	output logic [4:0] MEM_WB_Rd;

	//PC_Addr, DM_Read_Data, ALU_Result
	genvar i;
	generate
		for(i = 0; i< 64; i++) begin : eachDFF1
			en_reg u_en_reg_1i (.wrt_en(WB_en_in), .datain(PC_BL_in[i]), .reset(reset), .clk(clk), .dataout(PC_BL_out[i]));
			en_reg u_en_reg_2i (.wrt_en(WB_en_in), .datain(DM_Read_Data_in[i]), .reset(reset), .clk(clk), .dataout(DM_Read_Data_out[i]));
			en_reg u_en_reg_3i (.wrt_en(WB_en_in), .datain(ALU_Result_in[i]), .reset(reset), .clk(clk), .dataout(ALU_Result_out[i]));
		end
	endgenerate 
	
	//Instruction4_0
	genvar j;
	generate
		for(j = 0; j< 5; j++) begin : eachDFF2
			en_reg u_en_reg_4i (.wrt_en(WB_en_in), .datain(Instruction4_0[j]), .reset(reset), .clk(clk), .dataout(MEM_WB_Rd[j]));
		end
	endgenerate 
	
	//Control Signals
	//MemtoReg, BrLink
	en_reg u_en_reg_12 (.wrt_en(WB_en_in), .datain(MemtoReg_in), .reset(reset), .clk(clk), .dataout(MemtoReg_out));
	en_reg u_en_reg_15 (.wrt_en(WB_en_in), .datain(BrLink_in), .reset(reset), .clk(clk), .dataout(BrLink_out));
	en_reg u_en_reg_17 (.wrt_en(WB_en_in), .datain(RegWrite_in), .reset(reset), .clk(clk), .dataout(RegWrite_out));
	
endmodule 

module MEM_WB_tb();
	logic WB_en_in, MemtoReg_in, BrLink_in, RegWrite_in, reset, clk;
	logic [63:0] PC_BL_in, DM_Read_Data_in, ALU_Result_in;
	logic [4:0] Instruction4_0;
	
	logic MemtoReg_out, BrLink_out;
	logic [63:0] PC_BL_out, DM_Read_Data_out, RegWrite_out, ALU_Result_out;
	logic [4:0] MEM_WB_Rd;

	MEM_WB dut (.*);
	
	parameter CLOCK_PERIOD = 10000;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin

		 // Initial reset
		 reset = 1;
		 WB_en_in = 0;
		 PC_BL_in = 64'hAABBCCDD11223344;
		 DM_Read_Data_in = 64'h0000DEAD0000BEEF;
		 ALU_Result_in = 64'h1234567890ABCDEF;
		 Instruction4_0 = 5'b10101;
		 MemtoReg_in = 1;
		 BrLink_in = 0;
		 #10000;

		 // Release reset and enable write
		 reset = 0;
		 WB_en_in = 1;
		 #10000;

		 // Change inputs but disable write
		 WB_en_in = 0;
		 PC_BL_in = 64'hFEEDFACECAFEBEEF;
		 DM_Read_Data_in = 64'h1111222233334444;
		 ALU_Result_in = 64'h9999888877776666;
		 Instruction4_0 = 5'b01010;
		 MemtoReg_in = 0;
		 BrLink_in = 1;
		 #10000;

		 // Enable write again
		 WB_en_in = 1;
		 #10000;

		$stop;
	end	
endmodule