`timescale 1ps / 1ps
module mux32_64(in, sel, out);
	input logic [63:0] in [31:0]; 
	input logic [4:0] sel;
	output logic [63:0] out;
	
	genvar i,j;
	
	generate
		for(i = 0; i<64; i++) begin : eachMUX
			logic [31:0] bit_slice;
		
			for( j = 0; j <32; j++) begin : bit_MUX
				assign bit_slice[j] = in[j][i]; 
			end 
	
			mux32_1 m (.in(bit_slice), .sel(sel), .out(out[i]));
			
		end
	endgenerate 

	
endmodule

module mux32_64_testbench();
	logic [63:0] in [31:0]; 
	logic [4:0] sel;	
	logic [63:0] out;
	
	mux32_64 dut (.in, .sel, .out);
	
	integer i;
	
	initial begin
		for(i=0; i<32; i++) begin
			in[i] = 64'b0 + i;
		end 
	
		for(i=0; i<32; i++) begin	
			sel = i;					#1500;
		end 
		
	end
endmodule