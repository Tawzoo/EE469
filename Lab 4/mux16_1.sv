`timescale 1ps / 1ps
module mux16_1(in, sel, out);
	input logic [15:0] in; 
	input logic [3:0] sel;
	output logic out;
	
	logic m0_out, m1_out;
	
	mux8_1 m0 (.in(in[7:0]), .sel(sel[2:0]), .out(m0_out));
	mux8_1 m1 (.in(in[15:8]), .sel(sel[2:0]), .out(m1_out));
	mux2_1 m  (.i0(m0_out), .i1(m1_out), .sel(sel[3]), .out(out));
	
endmodule


module mux16_1_testbench();
	logic [15:0] in; 
	logic [3:0] sel;	
	logic out;
	
	mux16_1 dut (.in, .sel, .out);
	
	integer i;
	
	initial begin
		for(i=0; i<16; i++) begin
			sel = i;
			in = 16'b0;
			in[i] = 1'b1;		#750;		
		end
		
		in = 16'b1010_1010_1010_1010;
		
		for(i=0; i<16; i++) begin
			sel = i; 			#750;	
		end
		
		sel = 4'b1011; #750;
		 
		sel = 4'b1001; #750;
		
		sel = 4'b0100;	#750;
		
		
	end
endmodule