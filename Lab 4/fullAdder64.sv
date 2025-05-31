`timescale 1ps / 1ps
module fullAdder64 (A, B, out, carryout, overflow);

	input logic  [63:0] A, B;
	output logic [63:0] out; 
	output logic carryout, overflow;
	
	parameter Delay = 50;
	
	logic [63:0] carry_arr; 
	
	fullAdder first_add (.A(A[0]), .B(B[0]), .Cin(1'b0), .Sum(out[0]), .Cout(carry_arr[0]));

	genvar i;
	
	generate
		for(i = 1; i< 64; i++) begin : eachAdder
			fullAdder adder (.A(A[i]), .B(B[i]), .Cin(carry_arr[i-1]), .Sum(out[i]), .Cout(carry_arr[i]));

		end
	endgenerate 
	
	// flags 
	assign carryout = carry_arr[63];
	xor #Delay xor_Gate(overflow, carry_arr[63], carry_arr[62]);

endmodule 


module fullAdder64_tb ();

	logic [63:0] A, B;
	logic [63:0] out; 
	logic carryout, overflow;
	
	fullAdder64 dut (.*);
	

	initial begin

		// 0 + 0
		A = 64'd0;
		B = 64'd0;
		#6500; 

		// 1 + 1
		A = 64'd1;
		B = 64'd1;
		#6500; 

		// Unsigned max + 1 → carryout
		A = 64'hFFFFFFFFFFFFFFFF;
		B = 64'd1;
		#6500;

		// Signed overflow → positive + positive = negative
		A = 64'h7FFFFFFFFFFFFFFF;  // Max positive 64-bit signed
		B = 64'd1;
		#6500; 

		// Random pattern
		A = 64'h123456789ABCDEF0;
		B = 64'h0FEDCBA987654321;
		#6500; 

		// -2 + -1
		A = 64'hFFFFFFFFFFFFFFFE; // -2
		B = 64'hFFFFFFFFFFFFFFFF; // -1
		#6500; 
		  
	end
endmodule
