`timescale 1ps / 1ps
module fullSubtractor64 (A, B, out, carryout, overflow);

	input logic  [63:0] A, B;
	output logic [63:0] out; 
	output logic carryout, overflow;
	
	parameter Delay = 50;
	
	logic [63:0] carry_arr; 
	
	fullSubtractor first_subtractor (.A(A[0]), .B(B[0]), .Cin(1'b1), .Sum(out[0]), .Cout(carry_arr[0]));

	genvar i;
	
	generate
		for(i = 1; i< 64; i++) begin : eachSubtractor
			fullSubtractor Subtractor (.A(A[i]), .B(B[i]), .Cin(carry_arr[i-1]), .Sum(out[i]), .Cout(carry_arr[i]));

		end
	endgenerate 
	
	// flags 
	assign carryout = carry_arr[63];
	xor #Delay xor_Gate(overflow, carry_arr[63], carry_arr[62]);

endmodule 

module fullSubtractor64_tb ();

	logic [63:0] A, B;
	logic [63:0] out; 
	logic carryout, overflow;
	
	fullSubtractor64 dut (.*);
	

	initial begin

		// 0 - 0
		A = 64'd0;
		B = 64'd0;
		#10000; 

		// 5 - 3
		A = 64'd5;
		B = 64'd3;
		#10000; 
		
		// 2 - 3, carryout = 0
		A = 64'd2; 	// -2
		B = 64'd3;  // 3
		#10000; 

		// Signed overflow -> positive - positive = negative
		A = 64'h7FFFFFFFFFFFFFFF; // Max positive 64-bit signed
		B = 64'hFFFFFFFFFFFFFFFF; 
		#10000; 
		
		// Signed over -> negative - negative = positive 
		A = 64'h8000000000000000;   // -9223372036854775808 (signed min)
		B = 64'h0000000000000001;  // +1
		#10000; 

		// Random pattern
		A = 64'h123456789ABCDEF0;
		B = 64'h0FEDCBA987654321;
		#10000; 
		  
	end
endmodule