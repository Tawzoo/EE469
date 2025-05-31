`timescale 1ps / 1ps

module decoder4_16(i0, i1, i2, i3, en, out);
	input logic i0, i1, i2, i3, en;
	output logic [15:0]out;
	parameter Delay = 50;
	
	logic [1:0]en_arr;
	
	decoder1_2 decoder1_2_2(.i0(i3), .en(en), .out(en_arr));
	decoder3_8 decoder3_8_1(.i0(i0), .i1(i1), .i2(i2), .en(en_arr[0]), .out(out[7:0]));
	decoder3_8 decoder3_8_2(.i0(i0), .i1(i1), .i2(i2), .en(en_arr[1]), .out(out[15:8]));

endmodule

module decoder4_16_testbench();
	logic i0, i1, i2, i3, en;
	logic [15:0]out;
	decoder4_16 dut (.i0, .i1, .i2, .i3, .en, .out);
	
	initial begin
	en = 1;
	for (int i = 0; i < 16; i++) begin
		{i3, i2, i1, i0} = i[3:0];
		#1000;
	end
	
	en = 0;
	for (int i = 0; i < 16; i++) begin
		{i3, i2, i1, i0} = i[3:0];
		#1000;
	end
end
endmodule