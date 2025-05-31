`timescale 1ps / 1ps

module decoder3_8(i0, i1, i2, en, out);
	input logic i0, i1, i2, en;
	output logic [7:0]out;
	parameter Delay = 50;
	
	logic [1:0]en_arr;
	
	decoder1_2 decoder1_2_2(.i0(i2), .en(en), .out(en_arr));
	decoder2_4 decoder2_4_1(.i0(i0), .i1(i1), .en(en_arr[0]), .out(out[3:0]));
	decoder2_4 decoder2_4_2(.i0(i0), .i1(i1), .en(en_arr[1]), .out(out[7:4]));
	
endmodule

module decoder3_8_testbench();
	logic i0, i1, i2, en;
	logic [7:0]out;
	decoder3_8 dut (.i0, .i1, .i2, .en, .out);
	initial begin
		en=1; i2=0; i1=0; i0=0; #1000;
		en=1; i2=0; i1=0; i0=1; #1000;
		en=1; i2=0; i1=1; i0=0; #1000;
		en=1; i2=0; i1=1; i0=1; #1000;
		en=1; i2=1; i1=0; i0=0; #1000;
		en=1; i2=1; i1=0; i0=1; #1000;
		en=1; i2=1; i1=1; i0=0; #1000;
		en=1; i2=1; i1=1; i0=1; #1000;
		
		
		en=0; i2=0; i1=0; i0=0; #1000;
		en=0; i2=0; i1=0; i0=1; #1000;
		en=0; i2=0; i1=1; i0=0; #1000;
		en=0; i2=0; i1=1; i0=1; #1000;
		en=0; i2=1; i1=0; i0=0; #1000;
		en=0; i2=1; i1=0; i0=1; #1000;
		en=0; i2=1; i1=1; i0=0; #1000;
		en=0; i2=1; i1=1; i0=1; #1000;
	end
endmodule