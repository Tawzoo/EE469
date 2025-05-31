`timescale 1ps / 1ps
module mux2_1(i0, i1, sel, out);
	input logic i0, i1, sel;
	output logic out;
	parameter Delay = 50;
	
	logic i0_out, i1_out, sel_not; 
	
	not #Delay not_Gate(sel_not, sel);
	and #Delay and_Gate1(i0_out, i0, sel_not);
	and #Delay and_Gate2(i1_out, i1, sel);
	or #Delay or_Gate(out, i0_out, i1_out);


endmodule

module mux2_1_testbench();
	logic i0, i1, sel;
	logic out;
	
	mux2_1 dut (.i0, .i1, .sel, .out);
	
	initial begin 
		sel=0; i0=0; i1=0; #1000; // y = i0 = 0
		sel=0; i0=0; i1=1; #1000; // y = i0 = 0
		sel=0; i0=1; i1=0; #1000; // y = i0 = 1
		sel=0; i0=1; i1=1; #1000; // y = i0 = 1

		sel=1; i0=0; i1=0; #1000; // y = i1 = 0
		sel=1; i0=0; i1=1; #1000; // y = i1 = 1
		sel=1; i0=1; i1=0; #1000; // y = i1 = 0
		sel=1; i0=1; i1=1; #1000; // y = i1 = 1
	end
endmodule