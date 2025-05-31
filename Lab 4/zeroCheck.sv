`timescale 1ps / 1ps
module zeroCheck (check, zeroRes);

	input logic  [63:0] check;
	output logic zeroRes;
	
	parameter Delay = 50;
		
	logic  [15:0] orPass1;
	logic  [4:0] orPass2;
	logic passResult;
	
	genvar i;
	genvar k;
	
	generate
		for(i = 0; i< 16; i++) begin : orStage1
			or #Delay or_Gatei(orPass1[i], check[i*4], check[i*4+1], check[i*4+2], check[i*4+3]);
		end
	endgenerate 
	
	generate
		for(i = 0; i< 4; i++) begin : orStage2
			or #Delay or_Gatei(orPass2[i], orPass1[i*4], orPass1[i*4+1], orPass1[i*4+2], orPass1[i*4+3]);
		end
	endgenerate 

	or #Delay or_GateFinal(passResult, orPass2[0], orPass2[1], orPass2[2], orPass2[3]);
	not #Delay not_Gate(zeroRes, passResult);
	

endmodule 


module zeroCheck_tb ();
	logic [63:0] check;
	logic zeroRes;
	
	zeroCheck dut (.*);
	
	integer i;
	
	initial begin 
		check = 0; #6500;
		check = 1; #6500;
		check = 64'hFFFFFFFFFFFFFFFF; #6500;
		check = 64'hFFFFFFFFFFFFFFFF; #6500;
      check = 64'hAAAAAAAAAAAAAAAA; #6500;
		check = 64'h123456789ABCDEF0; #6500;
      check = 64'hFFFFFFFFFFFFFFFF; #6500;
	end
endmodule 