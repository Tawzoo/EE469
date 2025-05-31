`timescale 1ps / 1ps
module mux4_1(in, sel, out);
	input logic [3:0] in; 
	input logic [1:0] sel;
	output logic out;
	
	logic m0_out, m1_out;
	
	mux2_1 m0 (.i0(in[0]), .i1(in[1]), .sel(sel[0]), .out(m0_out));
	mux2_1 m1 (.i0(in[2]), .i1(in[3]), .sel(sel[0]), .out(m1_out));
	mux2_1 m  (.i0(m0_out), .i1(m1_out), .sel(sel[1]), .out(out));
	
endmodule

module mux4_1_testbench();
	logic [3:0] in; 
	logic [1:0] sel;	
	logic out;
	
	mux4_1 dut (.in, .sel, .out);
	
	integer i;
	
	initial begin
		for(i=0; i<64; i++) begin
			{sel, in} = i; #750;
		end
	end
endmodule