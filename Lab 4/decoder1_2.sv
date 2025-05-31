`timescale 1ps / 1ps

module decoder1_2(i0, en, out);
	input logic i0, en;
	output logic [1:0]out;
	parameter Delay = 50;
	
	logic index0_out;
	
	not #Delay not_Gate(index0_out, i0);
	and #Delay and_Gate1(out[0], index0_out, en);
	and #Delay and_Gate2(out[1], i0, en);


endmodule

module decoder1_2_testbench();
	logic i0, en;
	logic [1:0]out;
	decoder1_2 dut (.i0, .en, .out);
	initial begin
		en=1; i0=0; #1000;
		en=0; i0=0; #1000;
		en=0; i0=1; #1000;
		en=1; i0=1; #1000;
	end
endmodule