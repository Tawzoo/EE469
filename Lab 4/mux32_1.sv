`timescale 1ps / 1ps
module mux32_1(in, sel, out);
	input logic [31:0] in; 
	input logic [4:0] sel;
	output logic out;
	
	logic m0_out, m1_out;
	
	mux16_1 m0 (.in(in[15:0]), .sel(sel[3:0]), .out(m0_out));
	mux16_1 m1 (.in(in[31:16]), .sel(sel[3:0]), .out(m1_out));
	mux2_1 m  (.i0(m0_out), .i1(m1_out), .sel(sel[4]), .out(out));
	
endmodule

 
module mux32_1_testbench();
	logic [31:0] in; 
	logic [4:0] sel;	
	logic out;
	
	mux32_1 dut (.in, .sel, .out);
	
	integer i;
	
	initial begin
		for(i=0; i<32; i++) begin
			sel = i;
			in = 32'b0;
			in[i] = 1'b1;		#750;		
		end
		
		in = 32'b1010_1010_1010_1010_1010_1010_1010_1010;
		
		for(i=0; i<32; i++) begin
			sel = i; 			#750;	
		end
		
		sel = 5'b10110; #750;
		 
		sel = 5'b01101; #750;
		
		sel = 5'b00011; #750;
		 
		sel = 5'b11100; #750;
		
		sel = 5'b01010; #750;
		
	end
endmodule