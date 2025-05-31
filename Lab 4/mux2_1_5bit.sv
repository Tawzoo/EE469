`timescale 1ps / 1ps
module mux2_1_5bit(i0, i1, sel, out);
	input logic [4:0] i0, i1;
	input logic sel;
	output logic [4:0] out;
	parameter Delay = 50;
	
	logic [4:0] i0_out, i1_out;
	logic sel_not; 
	
	not #Delay not_Gate(sel_not, sel);
	
	genvar i;
	generate
		for(i=0; i<5; i++) begin : eachBit
			and #Delay and_Gate1(i0_out[i], i0[i], sel_not);
			and #Delay and_Gate2(i1_out[i], i1[i], sel);
			or #Delay or_Gate(out[i], i0_out[i], i1_out[i]);
		end
	endgenerate
endmodule