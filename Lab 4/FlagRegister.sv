`timescale 1ps / 1ps
module FlagRegister (clk, reset, en, in, out);
	input logic clk, reset, en;
	input logic [3:0] in;
	output logic [3:0] out;

	logic [3:0] store;

	genvar i;
	generate 
			for(i = 0; i < 4; i++) begin : flag_dff
					mux2_1 flag_mux (.i0(out[i]), .i1(in[i]), .sel(en), .out(store[i]));
					D_FF flag_dff (.q(out[i]), .d(store[i]), .reset(reset), .clk(clk));
			end
	endgenerate

endmodule 


module FlagRegister_tb();
	logic clk, reset, en;
	logic [3:0] in;
	logic [3:0] out;
		
	FlagRegister dut(.*);
	
	parameter clk_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(clk_PERIOD / 2) clk <= ~clk; // Clock toggle
	end

	initial begin
		// initial
		reset <= 1; en <= 0; in <= 4'b0000; 
			repeat(4) @(posedge clk); 
 
		// reset off 	
		reset <= 0;
			repeat(4) @(posedge clk);
		
		in = 4'b1010; en <= 1;
			repeat(4) @(posedge clk);
		
		en = 0; in = 4'b0110;
			repeat(4) @(posedge clk);

		in = 4'b1111; en <= 1;
			repeat(4) @(posedge clk);
			
		reset <= 1; in = 4'b0110;
			repeat(4) @(posedge clk);
		
	$stop;
	end
	
endmodule 