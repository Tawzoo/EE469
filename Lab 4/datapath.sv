`timescale 1ps / 1ps
module datapath(pc_out, read_data2, alu_result, instr, dm_read_data, dm_mem_write, dm_mem_read, clk, reset);
	input logic clk, reset;
	input logic [31:0] instr;
	input logic [63:0] dm_read_data;
	output logic dm_mem_write, dm_mem_read;
	output logic [63:0] pc_out, read_data2, alu_result; 
	logic negative, zero, overflow, carryout, negative_flag, zero_flag, overflow_flag, carryout_flag; 
	logic reg2loc_in, mem_to_reg, regwrite, uncondbranch, BrTaken, setflag, br2reg, alu_zero, BrLink;
	logic [4:0] read_reg2_input, wrt_reg;
	logic [2:0] alu_control;
	logic [1:0] alusrc;
	logic [63:0] read_data1, pc_in, pc_mux1_in, pc_mux2_in, pc_mux3_in, alusrc_mux_out, dp_writedata, shift_out, pc_br_addr;
	logic [63:0] se_out, CondAddressExt, BRAddressExt, Imm12Ext, Imm9Ext;
	 
	assign pc_br_addr = read_data2;
	
	// PC 
	pc program_counter(.reset(reset), .clk(clk), .datain(pc_in), .dataout(pc_out)); //PC
	
	// PC address based on Branching 
	sign_ext #(.IN_WIDTH(19)) UNCOND_extender(.in(instr[23:5]), .out(CondAddressExt)); // Sign Extender for CBZ
	sign_ext #(.IN_WIDTH(26)) BR_extender(.in(instr[25:0]), .out(BRAddressExt)); // Sign Extender for B
	mux2_1_64bit branch_mux (.i0(CondAddressExt), .i1(BRAddressExt), .sel(uncondbranch), .out(se_out)); //Branch Address Mux
	assign shift_out = {se_out[61:0], 2'b0}; //Shifter
	
	

	// PC Address Selection 
	fullAdder64 pc_adder0(.A(pc_out), .B(64'd4), .out(pc_mux1_in), .carryout(), .overflow()); //PC Adder 0
	fullAdder64 pc_adder1(.A(pc_out), .B(shift_out), .out(pc_mux2_in), .carryout(), .overflow()); //PC Adder 1
	fullAdder64 pc_adder2(.A(pc_out), .B(64'd4), .out(pc_mux3_in), .carryout(), .overflow());  // PC Adder 2
	mux4_1_64 pc_mux (.i3(pc_br_addr), .i2(64'b0), .i1(pc_mux2_in), .i0(pc_mux1_in), .sel({br2reg, BrTaken} ), .out(pc_in));
	
	
	// IMM for LDUR and ADDI 
	sign_ext #(.IN_WIDTH(9)) Imm9_extender(.in(instr[20:12]), .out(Imm9Ext)); // Sign Extender for LDUR
	zero_ext #(.IN_WIDTH(12)) ADDI_extender(.in(instr[21:10]), .out(Imm12Ext)); // Zero Extender for ADDI
	
	// Control Flags
	FlagRegister setflags (.reset(reset), .clk(clk), .en(setflag), .in({negative, zero, overflow, carryout}), .out({negative_flag, zero_flag, overflow_flag, carryout_flag}));
	control_unit controlUnit(.opcode(instr[31:21]), .negflag(negative_flag), .zeroflag(alu_zero), .overflag(overflow_flag), .ALUOp(alu_control), .SetFlag(setflag), 
									 .Reg2Loc(reg2loc_in), .Uncondbranch(uncondbranch), .BrTaken(BrTaken), .MemRead(dm_mem_read), .MemtoReg(mem_to_reg), 
									 .MemWrite(dm_mem_write), .ALUSrc(alusrc), .RegWrite(regwrite), .BrtoReg(br2reg), .BrLink(BrLink));
	assign alu_zero = zero; 
	
	// Registers 	
	mux2_1_5bit reg2loc_mux (.i0(instr[4:0]), .i1(instr[20:16]), .sel(reg2loc_in), .out(read_reg2_input)); //Reg2Loc mux
	regfile registers (.ReadData1(read_data1), .ReadData2(read_data2), .WriteData(dp_writedata), .ReadRegister1(instr[9:5]), 
							 .ReadRegister2(read_reg2_input), .WriteRegister(wrt_reg), .RegWrite(regwrite), .clk(clk)); //Registers
	
	// ALUSRC
	mux4_1_64 alusrc_mux (.i0(read_data2), .i1(Imm12Ext), .i2(Imm9Ext), .i3(64'bx), .sel(alusrc), .out(alusrc_mux_out));
	
	// ALU
	alu alu1 (.A(read_data1), .B(alusrc_mux_out), .cntrl(alu_control), .result(alu_result), .negative(negative), .zero(zero), .overflow(overflow), .carry_out(carryout)); //ALU
	
	// Memory 
	mux4_1_64 memtoreg_mux (.i3(64'b0), .i2(pc_mux3_in), .i1(dm_read_data), .i0(alu_result), .sel({BrLink, mem_to_reg}), .out(dp_writedata)); //MemtoReg Mux
	
	// Reg Write
	mux2_1_5bit reg_mux (.i0(instr[4:0]), .i1(5'd30), .sel(BrLink), .out(wrt_reg)); //Write Address Mux

	
	
endmodule 


module datapath_tb();
    logic clk, reset;
    logic [31:0] instr;
    logic [63:0] dm_read_data;
    logic dm_mem_write, dm_mem_read;
    logic [63:0] pc_out, read_data2, alu_result;

    datapath dut (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .dm_read_data(dm_read_data),
        .dm_mem_write(dm_mem_write),
        .dm_mem_read(dm_mem_read),
        .pc_out(pc_out),
        .read_data2(read_data2),
        .alu_result(alu_result)
    );

    // Clock generation
    parameter CLK_PERIOD = 10000;
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    initial begin
        // Initial values
        reset = 1;
        instr = 32'd0;
        dm_read_data = 64'd0;
        repeat(2) @(posedge clk);
        reset = 0;
			
		  // ADDI X0, X31, #0 (X0 = 0)
		  instr = 32'b10010001000000000000001111100000;
        repeat(10) @(posedge clk);
		  
        
		  // ADDI X0, X31, #1  
        instr = 32'b1001000100_000000000001_11111_00000;
        repeat(10) @(posedge clk);

//        // SUBS X1, X31, X0 (X1 = -1)
        instr = 32'b11101011000_00000_000000_11111_00001;
        repeat(10) @(posedge clk);
//
        // SUBS X2, X0, X1      // X2 =  2
        instr = 32'b11101011000_00001_000000_00000_00010   ;
        repeat(10) @(posedge clk);

        // Additional instruction tests can be added here

        $stop;
    end
endmodule
