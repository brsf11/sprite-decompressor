`timescale 1ps/1ps
module CCL_testbench();

    reg clk,rst_n;
    reg winc;
    reg[7:0] byte;
    wire CCL_rdy;
    wire[63:0] CCL_code_sq;
    wire[15:0] CCL_count_sq;

    CCL CCL(
        .clk(clk),
        .rst_n(rst_n),
        .winc(winc),
        .byte(byte),
        .CCL_rdy(CCL_rdy),
        .CCL_code_sq(CCL_code_sq),
        .CCL_count_sq(CCL_count_sq)
    );

    initial begin
        rst_n = 0;
        winc = 0;
        byte = 8'h0;
        #10;
        rst_n = 1;
        winc = 1;
        byte = 8'hda;
        #10;
        winc = 1;
        byte = 8'h8e;
        #10;
        winc = 1;
        byte = 8'h85;
        #10;
        winc = 1;
        byte = 8'hc0;
        #10;
        winc = 0;

    end

    always  begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end
endmodule