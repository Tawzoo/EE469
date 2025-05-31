`timescale 1ps / 1ps

module decoder5_32(i0, i1, i2, i3, i4, en, out);
	input logic i0, i1, i2, i3, i4, en;
	output logic [31:0]out;
	parameter Delay = 50;
	
	logic [1:0]en_arr;
	
	decoder1_2 decoder1_2_2(.i0(i4), .en(en), .out(en_arr));
	decoder4_16 decoder3_8_1(.i0(i0), .i1(i1), .i2(i2), .i3(i3), .en(en_arr[0]), .out(out[15:0]));
	decoder4_16 decoder3_8_2(.i0(i0), .i1(i1), .i2(i2), .i3(i3), .en(en_arr[1]), .out(out[31:16]));

endmodule

module decoder5_32_testbench();
	logic i0, i1, i2, i3, i4, en;
	logic [31:0]out;
	decoder5_32 dut (.i0, .i1, .i2, .i3, .i4, .en, .out);
	
	initial begin
	en = 1;
	for (int i = 0; i < 32; i++) begin
		{i4, i3, i2, i1, i0} = i[4:0];
		#1000;
	end
	
	en = 0;
	for (int i = 0; i < 32; i++) begin
		{i4, i3, i2, i1, i0} = i[4:0];
		#1000;
	end
end
endmodule