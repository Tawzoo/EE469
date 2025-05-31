`timescale 1ps / 1ps
module en_reg (wrt_en, reset, clk, datain, dataout);
	input logic wrt_en, reset, clk, datain;
	output logic dataout;
	
	logic d_int;
	
	mux2_1 dut (.i0(dataout), .i1(datain), .sel(wrt_en), .out(d_int));
	
	D_FF d_ff (.q(dataout), .d(d_int), .reset(reset), .clk(clk));
	
endmodule 


module en_reg_testbench ();
	logic wrt_en, datain, reset, clk;
	logic dataout;
	
	en_reg dut (.*);
	
	parameter clk_PERIOD=50;
	initial begin
		clk <= 0;
		forever #(clk_PERIOD/2) clk <= ~clk; // Forever toggle the clk
	end
	
	initial begin 
	
	wrt_en <= 0; datain <= 0; reset <= 1;
			repeat(4) @(posedge clk); 
			
	reset <= 0;
			repeat(4) @(posedge clk); 
	
	wrt_en <= 1; datain <= 1;
			repeat(4) @(posedge clk); 
			
	datain <= 0;
			repeat(4) @(posedge clk); 
	
	wrt_en <= 1; datain <= 1;
		repeat(2) @(posedge clk); 
	
	reset <= 1;
		repeat(4) @(posedge clk); 
	
	$stop;
	end
	
endmodule 