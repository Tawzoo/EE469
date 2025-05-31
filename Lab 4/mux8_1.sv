`timescale 1ps / 1ps
module mux8_1(in, sel, out);
	input logic [7:0] in; 
	input logic [2:0] sel;
	output logic out;
	
	logic m0_out, m1_out;
	
	mux4_1 m0 (.in(in[3:0]), .sel(sel[1:0]), .out(m0_out));
	mux4_1 m1 (.in(in[7:4]), .sel(sel[1:0]), .out(m1_out));
	mux2_1 m  (.i0(m0_out), .i1(m1_out), .sel(sel[2]), .out(out));
	
endmodule

module mux8_1_testbench();
	logic [7:0] in; 
	logic [2:0] sel;	
	logic out;
	
	mux8_1 dut (.in, .sel, .out);
	
	integer i;
	
	initial begin
		for(i=0; i<2048; i++) begin
			{sel, in} = i; #750;
		end
	end
endmodule