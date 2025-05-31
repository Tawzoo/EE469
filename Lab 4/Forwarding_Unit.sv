module Forwarding_Unit (ID_Rn, ID_Rm, EX_Rd, MEM_Rd, MEM_Rt, EX_RegWrite, MEM_RegWrite, MEM_WB_BRLink, MEM_MemWrite, forwardA, forwardB,forwardC);

	input logic [4:0] ID_Rn, ID_Rm, EX_Rd, MEM_Rd, MEM_Rt;
	input logic EX_RegWrite, MEM_RegWrite, MEM_WB_BRLink, MEM_MemWrite;
	output logic [1:0] forwardA, forwardB;
	output logic forwardC;
	
	always_comb begin
		// Default	
		if (EX_RegWrite && (EX_Rd == ID_Rn) && (EX_Rd != 5'd31)) begin
			forwardA = 2'b10;
		end 
		else if(MEM_RegWrite && (MEM_Rd == ID_Rn) && (MEM_Rd != 5'd31)) begin
			forwardA = 2'b01;
		end
		else if(MEM_WB_BRLink && (ID_Rn == 5'd30)) begin
			forwardA = 2'b11;
		end 
		else begin 
			forwardA = 2'b00;
		end 
		
		if (EX_RegWrite && (EX_Rd == ID_Rm) && (EX_Rd != 5'd31)) begin
			forwardB = 2'b10;
		end 
		else if(MEM_RegWrite && (MEM_Rd == ID_Rm) && (MEM_Rd != 5'd31)) begin
			forwardB = 2'b01;
		end
		else if(MEM_WB_BRLink && (ID_Rm == 5'd30)) begin
			forwardB = 2'b11;
		end
		else begin 
			forwardB = 2'b00;
		end 		
		
		if(EX_RegWrite && (EX_Rd == MEM_Rt) && (EX_Rd != 5'd31)) begin
			forwardC = 1'b1;
		end 
		else if (MEM_RegWrite && (MEM_Rd == MEM_Rt) && (MEM_Rd != 5'd31)) begin
			forwardC = 1'b1;
		end 
		else begin 
			forwardC = 1'b0;
		end 
		
		
		
	end 
	


endmodule