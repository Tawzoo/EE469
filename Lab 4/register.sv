`timescale 1ps / 1ps
module register (wrt_en, reset, clk, datain, dataout);
	input logic wrt_en, reset, clk;
	input logic [63:0] datain;
	output logic [63:0] dataout;
	
	genvar i;
	
	generate
		for(i = 0; i< 64; i++) begin : eachDFF
			en_reg u_en_reg_i (.wrt_en(wrt_en), .datain(datain[i]), .reset(reset), .clk(clk), .dataout(dataout[i]));

		end
	endgenerate 


endmodule 


module register_testbench ();
	logic wrt_en, reset, clk;
	logic [63:0] datain;
	logic [63:0] dataout;
	
	register dut (.*);
	
	parameter clk_PERIOD = 50;
	initial begin
		clk <= 0;
		forever #(clk_PERIOD / 2) clk <= ~clk; // Clock toggle
	end

	initial begin
		// Initial state
		wrt_en <= 0;
		datain <= 64'h0000000000000000;
		reset <= 1;
		repeat(4) @(posedge clk);

		// Release reset
		reset <= 0;
		repeat(4) @(posedge clk);

		// Write a known value
		wrt_en <= 1;
		datain <= 64'hDEADBEEFCAFEBABE;
		repeat(4) @(posedge clk);

		// Change input but disable write
		wrt_en <= 0;
		datain <= 64'h123456789ABCDEF0;
		repeat(4) @(posedge clk);

		// Enable write again
		wrt_en <= 1;
		datain <= 64'h0F0F0F0F0F0F0F0F;
		repeat(2) @(posedge clk);

		// Reset register
		reset <= 1;
		repeat(4) @(posedge clk);

		$stop;
	end

endmodule 