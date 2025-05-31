`timescale 1ps / 1ps
module alu(A, B, cntrl, result, negative, zero, overflow, carry_out);
	input  logic [63:0] A, B;
	input  logic [2:0]	 cntrl;
	output logic [63:0] result; 
	output logic negative, zero, overflow, carry_out;

	//parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
	
	logic [63:0] temp_out [7:0];
	logic [1:0] temp_cout, temp_ovrflow;
	
	// Operations 
	assign temp_out[0] = B; 
	assign temp_out[1] = 0;
	assign temp_out[7] = 0;
	
	fullAdder64 fAdd(.A, .B, .out(temp_out[2]), .carryout(temp_cout[0]), .overflow(temp_ovrflow[0]));
	fullSubtractor64 fSub(.A, .B, .out(temp_out[3]), .carryout(temp_cout[1]), .overflow(temp_ovrflow[1]));
	fullAnd64 fAnd(.A, .B, .out(temp_out[4]));
	fullOr64 fOr(.A, .B, .out(temp_out[5]));
	fullXor64 fXor(.A, .B, .out(temp_out[6]));
	
	// result 
	mux8_64 m_out 		(.in(temp_out), .sel(cntrl), .out(result));
	
	// Carry-out
	mux2_1 m_cout 		(.i0(temp_cout[0]), .i1(temp_cout[1]), .sel(cntrl[0]), .out(carry_out));
	
	// Overflow 
	mux2_1 m_ovrflow  (.i0(temp_ovrflow[0]), .i1(temp_ovrflow[1]), .sel(cntrl[0]), .out(overflow)); 
	
	// Negative 
	assign negative = result[63];
	
	// Zero (Finish zero checker)
	zeroCheck z_check  (.check(result), .zeroRes(zero)); 
	
	
endmodule