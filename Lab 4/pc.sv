`timescale 1ps / 1ps
//module pc (reset, clk, datain, dataout);
//    input logic reset, clk;
//    input logic [63:0] datain;
//    output logic [63:0] dataout;
//
//    genvar i;
//
//    generate
//        for(i = 0; i< 64; i++) begin : eachDFF
//            D_FF dff1 (.q(dataout[i]), .d(datain[i]), .reset(reset), .clk(clk));
//
//        end
//    endgenerate 

module pc (reset, clk, wrt_en, datain, dataout);
    input logic reset, clk, wrt_en;
    input logic [63:0] datain;
    output logic [63:0] dataout;

    genvar i;

    generate
        for(i = 0; i< 64; i++) begin : eachDFF
           en_reg u_en_reg_i (.wrt_en(wrt_en), .datain(datain[i]), .reset(reset), .clk(clk), .dataout(dataout[i]));

        end
    endgenerate
endmodule