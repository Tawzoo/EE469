`timescale 1ps / 1ps
module fullAnd64 (A, B, out);

	input logic  [63:0] A, B;
	output logic [63:0] out;
	
	parameter Delay = 50;

	genvar i;
	
	generate
		for(i = 0; i< 64; i++) begin : eachAnd
			and #Delay and_Gatei(out[i], A[i], B[i]);

		end
	endgenerate 
	
endmodule 


module fullAnd64_tb ();
	logic [63:0] A, B, out;
	
	fullAnd64 dut (.*);
	
	integer i;
	
	initial begin 
		A=0; B=0; #6500;
		A=1; B=0; #6500;
		A=64'hFFFFFFFFFFFFFFFF; B=0; #6500;
		A=64'hFFFFFFFFFFFFFFFF; B=64'hFFFFFFFFFFFFFFFF; #6500;
      A = 64'hAAAAAAAAAAAAAAAA; B = 64'h5555555555555555; #6500;
		A = 64'h123456789ABCDEF0; B = 64'h0F0F0F0F0F0F0F0F; #6500;
      A = 64'hFFFFFFFFFFFFFFFF; B = 64'h0000000000000000; #6500;
	end
endmodule 
