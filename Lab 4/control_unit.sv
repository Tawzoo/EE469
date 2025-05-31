`timescale 1ps / 1ps
//module control_unit(opcode, ALUOp, Reg2Loc, Uncondbranch, BrTaken, MemRead, 
//							MemtoReg, MemWrite, ALUSrc, RegWrite);
module control_unit(opcode, negflag, zeroflag, overflag, ALUOp, 
							SetFlag, Reg2Loc, Uncondbranch, BrTaken, MemRead, 
							MemtoReg, MemWrite, ALUSrc, RegWrite, BrtoReg, BrLink,
							IF_en, WB_en, Mem_en, EX_en);
							
	input  logic [10:0] opcode;
	input  logic negflag, zeroflag, overflag;
	output logic [2:0]  ALUOp;
	output logic [1:0]  ALUSrc;
	output logic SetFlag, Reg2Loc, Uncondbranch, BrTaken, MemRead, MemtoReg, MemWrite, RegWrite, BrtoReg, BrLink, IF_en, WB_en, Mem_en, EX_en;
	
	
	always_comb begin
		// Default	
		casex(opcode)
			default: 
				begin
					SetFlag		  = 1'b0;
					Reg2Loc       = 1'b0;
					ALUSrc  		  = 2'b00;
					MemtoReg  	  = 1'b0;
					RegWrite  	  = 1'b0;
					MemWrite  	  = 1'b0;
					MemRead       = 1'b0;
					BrTaken       = 1'b0;
					BrtoReg		  = 1'b0;
					Uncondbranch  = 1'b0;
					ALUOp 		  = 3'b000;
					BrLink		  = 1'b0;
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;
				end
			// ADDI
			11'b1001000100x: 
				begin
					SetFlag		  = 1'b0;
					Reg2Loc       = 1'b1;
					ALUSrc  		  = 2'b01;
					MemtoReg  	  = 1'b0;			
					RegWrite  	  = 1'b1;
					MemWrite  	  = 1'b0;
					MemRead       = 1'b0;
					BrTaken       = 1'b0;
					BrtoReg		  = 1'b0;
					Uncondbranch  = 1'b0;
					BrLink		  = 1'b0;
					ALUOp 		  = 3'b010;
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;
				end
				
			// ADDS	
			11'b10101011000:
				begin
					SetFlag		  = 1'b1;
					Reg2Loc       = 1'b1;
					ALUSrc  		  = 2'b00;
					MemtoReg  	  = 1'b0;
					RegWrite  	  = 1'b1;
					MemWrite  	  = 1'b0;
					MemRead       = 1'b0;
					BrTaken       = 1'b0;
					BrtoReg		  = 1'b0;
					Uncondbranch  = 1'b0;
					BrLink		  = 1'b0;
					ALUOp 		  = 3'b010;	
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;	
				end
				
			//B
			11'b000101xxxxx:
				begin
					SetFlag		  = 1'b0;
					Reg2Loc       = 1'b0;
					ALUSrc  		  = 2'b00;
					MemtoReg  	  = 1'b0;			
					RegWrite  	  = 1'b0;
					MemWrite  	  = 1'b0;
					MemRead       = 1'b0;
					BrTaken       = 1'b1;
					BrtoReg		  = 1'b0;
					Uncondbranch  = 1'b1;
					BrLink		  = 1'b0;
					ALUOp 		  = 3'b000;	
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;	
				end
			
			//B.LT
			11'b01010100xxx:
				begin
					SetFlag		  = 1'b0;
					Reg2Loc       = 1'b0;
					ALUSrc  		  = 2'b00;
					MemtoReg  	  = 1'b0;			
					RegWrite  	  = 1'b0;
					MemWrite  	  = 1'b0;
					MemRead       = 1'b0;
					BrTaken       = (negflag ^ overflag);
					BrtoReg		  = 1'b0;
					Uncondbranch  = 1'b0;
					BrLink		  = 1'b0;
					ALUOp 		  = 3'b000;
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;		
				end
			
			// BL
			11'b100101xxxxx:
				begin
					SetFlag		  = 1'b0;
					Reg2Loc       = 1'b0;
					ALUSrc  		  = 2'b00;
					MemtoReg  	  = 1'b0;			
					RegWrite  	  = 1'b1;
					MemWrite  	  = 1'b0;
					MemRead       = 1'b0;
					BrTaken       = 1'b1;
					BrtoReg		  = 1'b0;
					Uncondbranch  = 1'b1;
					BrLink		  = 1'b1;
					ALUOp 		  = 3'b000;	
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;
					
				end
						
			// BR
			11'b11010110000:
				begin
					SetFlag		  = 1'b0;
					Reg2Loc       = 1'b0;
					ALUSrc  		  = 2'b00;
					MemtoReg  	  = 1'b0;			
					RegWrite  	  = 1'b0;
					MemWrite  	  = 1'b0;
					MemRead       = 1'b0;
					BrTaken       = 1'b1;
					BrtoReg		  = 1'b1;
					Uncondbranch  = 1'b0;
					BrLink		  = 1'b0;
					ALUOp 		  = 3'b000;	
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;	
				end
							
			// CBZ
			11'b10110100xxx:
				begin
					SetFlag		  = 1'b0;
					Reg2Loc       = 1'b0;
					ALUSrc  		  = 2'b00;
					MemtoReg  	  = 1'b0;			
					RegWrite  	  = 1'b0;
					MemWrite  	  = 1'b0;
					MemRead       = 1'b0;
					BrTaken       = zeroflag;
					BrtoReg		  = 1'b0;
					Uncondbranch  = 1'b0;
					BrLink		  = 1'b0;
					ALUOp 		  = 3'b000;
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;
				end

								
			// LDUR
			11'b11111000010:
				begin
					SetFlag		  = 1'b0;
					Reg2Loc       = 1'b0;
					ALUSrc  		  = 2'b10;
					MemtoReg  	  = 1'b1;			
					RegWrite  	  = 1'b1;
					MemWrite  	  = 1'b0;
					MemRead       = 1'b1;
					BrTaken       = 1'b0;
					BrtoReg		  = 1'b0;
					Uncondbranch  = 1'b0;
					BrLink		  = 1'b0;
					ALUOp 		  = 3'b010;	
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;	
				end
								
			// STUR
			11'b11111000000:
				begin
					SetFlag		  = 1'b0;
					Reg2Loc       = 1'b0;
					ALUSrc  		  = 2'b10;
					MemtoReg  	  = 1'b0;			
					RegWrite  	  = 1'b0;
					MemWrite  	  = 1'b1;
					MemRead       = 1'b0;
					BrTaken       = 1'b0;
					BrtoReg		  = 1'b0;
					Uncondbranch  = 1'b0;
					BrLink		  = 1'b0;
					ALUOp 		  = 3'b010;
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;
				end
								
			// SUBS
			11'b11101011000:
				begin
					SetFlag		  = 1'b1;
					Reg2Loc       = 1'b1;
					ALUSrc  		  = 2'b00;
					MemtoReg  	  = 1'b0;
					RegWrite  	  = 1'b1;
					MemWrite  	  = 1'b0;
					MemRead       = 1'b0;
					BrTaken       = 1'b0;
					BrtoReg		  = 1'b0;
					Uncondbranch  = 1'b0;
					BrLink		  = 1'b0;
					ALUOp 		  = 3'b011;	
					IF_en 		  = 1'b1;
					WB_en 		  = 1'b1;
					Mem_en 		  = 1'b1;
					EX_en			  = 1'b1;
				end				

		endcase
	end 
endmodule

module control_unit_tb();
		logic [10:0] opcode;
		logic negflag, zeroflag, overflag;
		logic [2:0]  ALUOp;
		logic SetFlag, Reg2Loc, Uncondbranch, BrTaken, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, BrtoReg, BrLink, IF_en, WB_en, Mem_en, EX_en;
		
		control_unit dut(.*);
		
		initial begin
			 // ADDI Test
			 opcode = 11'b10010001000; zeroflag = 0; negflag = 0; overflag = 0; #10000;

			 // ADDS Test
			 opcode = 11'b10101011000; zeroflag = 0; negflag = 0; overflag = 0; #10000;

			 // B Test (unconditional)
			 opcode = 11'b00010100000; zeroflag = 0; negflag = 0; overflag = 0; #10000;

			 // B.LT Test 1
			 opcode = 11'b01010100000; zeroflag = 0; negflag = 0; overflag = 0; #10000;

			 // B.LT Test 2
			 opcode = 11'b01010100001; zeroflag = 0; negflag = 1; overflag = 0; #10000;
			 opcode = 11'b01010100010; zeroflag = 0; negflag = 0; overflag = 1; #10000;

			 // BL Test
			 opcode = 11'b10010100000; zeroflag = 0; negflag = 0; overflag = 0; #10000;

			 // BR Test
			 opcode = 11'b11010110000; zeroflag = 0; negflag = 0; overflag = 0; #10000;

			 // CBZ Test - Not taken
			 opcode = 11'b10110100000; zeroflag = 0; negflag = 0; overflag = 0; #10000;

			 // CBZ Test - Taken
			 opcode = 11'b10110100001; zeroflag = 1; negflag = 0; overflag = 0; #10000;

			 // LDUR Test
			 opcode = 11'b11111000010; zeroflag = 0; negflag = 0; overflag = 0; #10000;

			 // STUR Test
			 opcode = 11'b11111000000; zeroflag = 0; negflag = 0; overflag = 0; #10000;

			 // SUBS Test
			 opcode = 11'b11101011000; zeroflag = 0; negflag = 0; overflag = 0; #10000;
		end

endmodule