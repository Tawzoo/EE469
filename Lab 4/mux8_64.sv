`timescale 1ps / 1ps
module mux8_64(in, sel, out);
	input logic [63:0] in [7:0]; 
	input logic [2:0] sel;
	output logic [63:0] out;
	
	genvar i,j;
	
	generate
		for(i = 0; i<64; i++) begin : eachMUX
			logic [7:0] bit_slice;
		
			for( j = 0; j <8; j++) begin : bit_MUX
				assign bit_slice[j] = in[j][i]; 
			end 
	
			mux8_1 m (.in(bit_slice), .sel(sel), .out(out[i]));
			
		end
	endgenerate 

	
endmodule

module mux8_64_tb();
	logic [63:0] in [7:0]; 
	logic [2:0] sel;	
	logic [63:0] out;
	
	mux8_64 dut (.in, .sel, .out);
	
	integer i;
	
	initial begin
		for(i=0; i<8; i++) begin
			in[i] = 64'b0 + i;
		end 
	
		for(i=0; i<8; i++) begin	
			sel = i;						#1500;
		end 
		
	end
endmodule