`timescale 1ps / 1ps
module zero_ext #(parameter IN_WIDTH = 32)(in, out);
	input logic [IN_WIDTH-1:0] in;
	output logic [63:0] out;
	
	genvar i;
	
	generate
		for(i = 0; i< IN_WIDTH; i++) begin : copyOriginal
			assign out[i] = in[i];

		end
		for(i = IN_WIDTH; i< 64; i++) begin : copyZero
			assign out[i] = 1'b0;
			
		end
	endgenerate 

endmodule



module zero_ext_testbench ();
	parameter IN_WIDTH = 10;
	logic [IN_WIDTH-1:0] in;
	logic [63:0] out;
	logic clk;
	
	zero_ext #(IN_WIDTH) dut (.*);
	
	parameter clk_PERIOD = 50;
	
	
	initial begin
		clk <= 0;
		forever #(clk_PERIOD / 2) clk <= ~clk; // Clock toggle
	end

	initial begin
		// Initial state
		in <= -1;
		repeat(4) @(posedge clk);

		in <= 2;
		repeat(4) @(posedge clk);
		
		in <= 55;
		repeat(4) @(posedge clk);
		
		in <= -55;
		repeat(4) @(posedge clk);

		$stop;
	end

endmodule 