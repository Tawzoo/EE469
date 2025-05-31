// Test bench for ALU
`timescale 1ns/10ps

// Meaning of signals in and out of the ALU:

// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.

// cntrl			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

module alustim();

	parameter delay = 100000;

	logic		[63:0]	A, B;
	logic		[2:0]		cntrl;
	logic		[63:0]	result;
	logic					negative, zero, overflow, carry_out ;

	parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	

	alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);

	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	integer i;
	logic [63:0] test_val;
	initial begin
	
		$display("%t testing PASS_B operations", $time);
		cntrl = ALU_PASS_B;
		for (i=0; i<100; i++) begin
			A = $random(); B = $random();
			#(delay);
			assert(result == B && negative == B[63] && zero == (B == '0));
		end
		
		$display("%t testing addition", $time);
		cntrl = ALU_ADD;
		A = 64'h0000000000000001; B = 64'h0000000000000001;
		#(delay);
		assert(result == 64'h0000000000000002 && carry_out == 0 && overflow == 0 && negative == 0 && zero == 0);
		
		// Unsigned max + 1 → carryout
		A = 64'hFFFFFFFFFFFFFFFF;
		B = 64'd1;
		#(delay);
		assert(result == 64'h0000000000000000 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 1);
		
		// Signed overflow → positive + positive = negative
		A = 64'h7FFFFFFFFFFFFFFF;  // Max positive 64-bit signed
		B = 64'd2;
		#(delay);
		assert(result == 64'h8000_0000_0000_0001 && carry_out == 0 && overflow == 1 && negative == 1 && zero == 0);
		
		// -2 + -1
		A = 64'hFFFFFFFFFFFFFFFE; // -2     
		B = 64'hFFFFFFFFFFFFFFFF; // -1
		#(delay);
		assert(result == 64'hFFFFFFFFFFFFFFFD && carry_out == 1 && overflow == 0 && negative == 1 && zero == 0);
		
		// -2 + 2
		A = 64'hFFFFFFFFFFFFFFFE; // -2    
		B = 64'h0000000000000002; // 2 
		#(delay);       
		assert(result == 64'h0000000000000000 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 1);
		
		
		
		$display("%t testing subtraction", $time);
		cntrl = ALU_SUBTRACT;
		// 0 - 0
		A = 64'd0;
		B = 64'd0;
		#(delay);       
		assert(result == 64'h0000000000000000 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 1);

		// 5 - 3
		A = 64'd5;
		B = 64'd3;
		#(delay);       
		assert(result == 64'h0000000000000002 && carry_out == 1 && overflow == 0 && negative == 0 && zero == 0);
		
		// 2 - 3, carryout = 0
		A = 64'd2; 	// 2
		B = 64'd3;  // 3
		#(delay);       
		assert(result == 64'hFFFFFFFFFFFFFFFF && carry_out == 0 && overflow == 0 && negative == 1 && zero == 0);

		// Signed overflow -> positive - negative = positive
		A = 64'h7FFFFFFFFFFFFFFF; // Max positive 64-bit signed
		B = 64'hFFFFFFFFFFFFFFFF; //-1
		#(delay);       
		assert(result == 64'h8000000000000000 && carry_out == 0 && overflow == 1 && negative == 1 && zero == 0);
		
		// Signed over -> negative - positive = positive 
		A = 64'h8000000000000000;   // -9223372036854775808 (signed min)
		B = 64'h0000000000000001;  // +1
		#(delay);       
		assert(result == 64'h7FFFFFFFFFFFFFFF && carry_out == 1 && overflow == 1 && negative == 0 && zero == 0); 
		
		
		
		$display("%t testing and", $time);
		cntrl = ALU_AND;
		// zero
		A = 64'h0000000000000000; B = 64'h0000000000000000;
		#(delay);
		assert(result == 64'h0000000000000000 && negative == 0 && zero == 1);
		
		// "negative"
		A = 64'hFFFFFFFFFFFFFFFF;
		B = 64'h8000000000000000;
		#(delay);
		assert(result == 64'h8000000000000000 && negative == 1 && zero == 0);
		
		// random
		A = 64'h7540268456545896;
		B = 64'h5874589632145632;
		#(delay);
		assert(result == 64'h5040008412145012 && negative == 0 && zero == 0);
		
		
		
		$display("%t testing or", $time);
		cntrl = ALU_OR;
		// zero
		A = 64'h0000000000000000; B = 64'h0000000000000000;
		#(delay);
		assert(result == 64'h0000000000000000 && negative == 0 && zero == 1);
		
		// "negative"
		A = 64'h0000000000000000;
		B = 64'h8000000000000000;
		#(delay);
		assert(result == 64'h8000000000000000 && negative == 1 && zero == 0);
		
		// random
		A = 64'h7540268456545896;
		B = 64'h5874589632145632;
		#(delay);
		assert(result == 64'h7d747e9676545eb6 && negative == 0 && zero == 0);
		
		
		
		$display("%t testing xor", $time);
		cntrl = ALU_XOR;
		// zero
		A = 64'h0000000000000000; B = 64'h0000000000000000;
		#(delay);
		assert(result == 64'h0000000000000000 && negative == 0 && zero == 1);
		
		// "negative"
		A = 64'h0000000000000000;
		B = 64'h8000000000000000;
		#(delay);
		assert(result == 64'h8000000000000000 && negative == 1 && zero == 0);
		
		// random
		A = 64'h7540268456545896;
		B = 64'h5874589632145632;
		#(delay);
		assert(result == 64'h2d347e1264400ea4 && negative == 0 && zero == 0);
		
		
	end
endmodule
