`timescale 1ps / 1ps

module decoder2_4(i0, i1, en, out);
	input logic i0, i1, en;
	output logic [3:0]out;
	parameter Delay = 50;
	
	logic [1:0]en_arr;
	logic [1:0]lower_out;
	logic [1:0]upper_out;
	
	decoder1_2 decoder1_2_1(.i0(i1), .en(en), .out(en_arr));
	decoder1_2 decoder1_2_2(.i0(i0), .en(en_arr[0]), .out(lower_out));
	decoder1_2 decoder1_2_3(.i0(i0), .en(en_arr[1]), .out(upper_out));
	
	and #Delay and_Gate1(out[0], lower_out[0], en);
	and #Delay and_Gate2(out[1], lower_out[1], en);
	and #Delay and_Gate3(out[2], upper_out[0], en);
	and #Delay and_Gate4(out[3], upper_out[1], en);

endmodule

module decoder2_4_testbench();
	logic i0, i1, en;
	logic [3:0]out;
	decoder2_4 dut (.i0, .i1, .en, .out);
	initial begin
		en=1; i1=0; i0=0; #1000;
		en=1; i1=0; i0=1; #1000;
		en=1; i1=1; i0=0; #1000;
		en=1; i1=1; i0=1; #1000;
		en=0; i1=0; i0=0; #1000;
		en=0; i1=0; i0=1; #1000;
		en=0; i1=1; i0=0; #1000;
		en=0; i1=1; i0=1; #1000;
	end
endmodule