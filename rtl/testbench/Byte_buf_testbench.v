`timescale 1ps/1ps
module Byte_buf_testbench();

    reg clk,rst_n;
    reg enb;
    reg[1:0] addr;
    reg[7:0] byte;
    wire[29:0] CCL_sq;

    Byte_buf Byte_buf(
        .clk(clk),
        .rst_n(rst_n),
        .enb(enb),
        .buf_addr(addr),
        .byte(byte),
        .CCL_sq(CCL_sq)
    );

    initial begin
        rst_n = 0;
        enb   = 0;
        addr  = 2'b00;
        byte  = 8'h0;
        #10;
        rst_n = 1;
        enb   = 1;
        addr  = 2'b00;
        byte  = 8'hda;
        #10;
        enb   = 1;
        addr  = 2'b01;
        byte  = 8'h8e;
        #10;
        enb   = 1;
        addr  = 2'b10;
        byte  = 8'h85;
        #10;
        enb   = 1;
        addr  = 2'b11;
        byte  = 8'hc0;
        #10;
        enb   = 0;
    end

    always begin
        clk = 0;
        #5;
        clk = 1;
        #5; 
    end
endmodule