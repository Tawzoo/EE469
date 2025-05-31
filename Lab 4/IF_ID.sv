`timescale 1ps / 1ps
module IF_ID (IF_ID_en, reset, clk, PC_Addr_in, PC_Addr_out, PC_BL_in, PC_BL_out, Instruction_in, Instruction_out);
	input logic IF_ID_en, reset, clk;
	input logic [63:0] PC_Addr_in, PC_BL_in;
	input logic [31:0] Instruction_in;
	output logic [63:0] PC_Addr_out, PC_BL_out;
	output logic [31:0] Instruction_out;
	
	//PC_Addr
	genvar i;
	generate
		for(i = 0; i< 64; i++) begin : eachDFF1
			en_reg u_en_reg_1i (.wrt_en(IF_ID_en), .datain(PC_Addr_in[i]), .reset(reset), .clk(clk), .dataout(PC_Addr_out[i]));
		end
	endgenerate 
	
	//Instruction
	genvar j;
	generate
		for(j = 0; j< 32; j++) begin : eachDFF2
			en_reg u_en_reg_2i (.wrt_en(IF_ID_en), .datain(Instruction_in[j]), .reset(reset), .clk(clk), .dataout(Instruction_out[j]));
		end
	endgenerate 
	
	genvar k;
	generate
		for(k = 0; k< 64; k++) begin : eachDFF3
			en_reg u_en_reg_3i (.wrt_en(IF_ID_en), .datain(PC_BL_in[k]), .reset(reset), .clk(clk), .dataout(PC_BL_out[k]));
		end
	endgenerate 
	
endmodule 

module IF_ID_tb ();
	logic IF_ID_en, reset, clk;
	logic [63:0] PC_Addr_in, PC_BL_in;	
	logic [31:0] Instruction_in;	
	logic [63:0] PC_Addr_out, PC_BL_out;	
	logic [31:0] Instruction_out;	
	
	
	integer i;
	
	IF_ID dut (.*);
	
	parameter clk_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(clk_PERIOD / 2) clk <= ~clk; // Clock toggle
	end

	initial begin

    // Initial values
    reset = 1;
    IF_ID_en = 0;
    PC_Addr_in = 64'd40;
    Instruction_in = 32'hDEADBEEF;
    #10000; // Allow one clock edge

    reset = 0;
    IF_ID_en = 1;
    PC_Addr_in = 64'd10;
    Instruction_in = 32'h12345678;
    #10000;


    // Change input but disable write
    IF_ID_en = 0;
    PC_Addr_in = 64'd1;
    Instruction_in = 32'hCAFEBABE;
    #10000;


    // Enable write again
    IF_ID_en = 1;
    PC_Addr_in = 64'd3;
    Instruction_in = 32'hFFFFFFFF;
    #10000;


    $stop;

	end


endmodule 