`timescale 1ps / 1ps
module fullSubtractor(A, B, Cin, Sum, Cout);

	input logic A, B, Cin;
	output logic Sum, Cout;
	
	parameter Delay = 50;
	
	logic inv_B; 
	
	not #Delay not_Gate(inv_B, B);
	
	fullAdder add(.A, .B(inv_B), .Cin, .Sum, .Cout);

endmodule 


module fullSubtractor_tb();

	logic A, B, Cin;
	logic Sum, Cout;
	
	fullSubtractor dut (.*);
	
	initial begin 
		A=0; B=0; Cin=1; #1000; // Cout = 1 Sum = 0
		A=0; B=1; Cin=1; #1000; // Cout = 0 Sum = 1
		A=1; B=0; Cin=1; #1000; // Cout = 1 Sum = 1
		A=1; B=1; Cin=1; #1000; // Cout = 1 Sum = 0
	end
	
endmodule