`timescale 1ps/1ps
module fifo_testbench();

    reg clk,rst_n;
    reg winc,rinc;
    reg[7:0] wdata;
    wire wfull,rempty;
    wire[7:0] rdata;

    FIFO_synq fifo(
        .clk(clk),
        .rst_n(rst_n),
        .winc(winc),
        .rinc(rinc),
        .wdata(wdata),
        .wfull(wfull),
        .rempty(rempty),
        .rdata(rdata)
    );

    initial begin
        rst_n = 0;
        winc = 0;
        rinc = 0;
        wdata = 8'b1111_0000;
        #10;
        rst_n = 1;
        winc = 1;
        #10;
        wdata = 8'b1010_0000;
        #10;
        wdata = 8'b1010_0001;
        #10;
        wdata = 8'b1010_0010;
        #10;
        wdata = 8'b1010_0100;
        #10;
        wdata = 8'b1010_1000;
        #10;
        wdata = 8'b1010_0011;
        #10;
        wdata = 8'b1010_0111;
        #10;
        winc = 0;
        rinc = 1;
        #200;
        winc = 1;

    end

    always begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end


endmodule