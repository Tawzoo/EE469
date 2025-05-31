`timescale 1ps / 1ps
module fullAdder (A, B, Cin, Sum, Cout);

	input logic A, B, Cin;
	output logic Sum, Cout;
	
	parameter Delay = 50;
	
	logic AB, BCin, ACin; 
	
	// Carryout
	and #Delay and_Gate1(AB, A, B);
	and #Delay and_Gate2(BCin, B, Cin);
	and #Delay and_Gate3(ACin, A, Cin);
	or #Delay or_Gate(Cout, AB, BCin, ACin);
	
	// Sum
	xor #Delay xor_Gate1 (Sum, A, B, Cin); 

endmodule 

module fullAdder_tb();

	logic A, B, Cin;
	logic Sum, Cout;
	
	fullAdder dut (.*);
	
	
	initial begin 
		A=0; B=0; Cin=0; #1000; // Cout = 0 Sum = 0
		A=0; B=0; Cin=1; #1000; // Cout = 0 Sum = 1
		A=0; B=1; Cin=0; #1000; // Cout = 0 Sum = 1
		A=0; B=1; Cin=1; #1000; // Cout = 1 Sum = 0
		A=1; B=0; Cin=0; #1000; // Cout = 0 Sum = 1
		A=1; B=0; Cin=1; #1000; // Cout = 1 Sum = 0
		A=1; B=1; Cin=0; #1000; // Cout = 1 Sum = 0
		A=1; B=1; Cin=1; #1000; // Cout = 1 Sum = 1
	end
endmodule