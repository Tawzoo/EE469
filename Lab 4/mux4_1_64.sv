`timescale 1ps / 1ps
module mux4_1_64(i0, i1, i2, i3, sel, out);
	input logic [63:0] i0, i1, i2, i3; 
	input logic [1:0] sel;
	output logic [63:0] out;
	
	logic [63:0] m0_out, m1_out;
	
	mux2_1_64bit m0 (.i0(i0), .i1(i1), .sel(sel[0]), .out(m0_out));
	mux2_1_64bit m1 (.i0(i2), .i1(i3), .sel(sel[0]), .out(m1_out));
	mux2_1_64bit m  (.i0(m0_out), .i1(m1_out), .sel(sel[1]), .out(out));
	
endmodule
