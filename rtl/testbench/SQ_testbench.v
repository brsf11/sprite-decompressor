`timescale 1ps/1ps
module SQ_testbench();

    reg clk,rst_n;
    reg fetch,wfull;
    reg[6:0] pointer;
    wire[79:0] bit;
    wire bit_out;
    wire[63:0] CCL_code_sq;
    wire[15:0] CCL_count_sq;
    wire fin,bit_req;
    wire[3:0] wdata;
    wire winc;

    reg fetch_musk,wfull_musk;

    SQ SQ(
        .clk(clk),
        .rst_n(rst_n),
        .fetch(fetch&fetch_musk),
        .wfull(wfull|wfull_musk),
        .bit(bit_out),
        .CCL_code_sq(CCL_code_sq),
        .CCL_count_sq(CCL_count_sq),
        .fin(fin),
        .bit_req(bit_req),
        .wdata(wdata),
        .winc(winc)
    );

    initial begin
        rst_n = 0;
        wfull = 0;
        #10;
        rst_n = 1;
    end

    assign bit_out = bit[pointer];

    assign CCL_code_sq  = {4'h7,4'h3,4'hf,4'hf,
                           4'hf,4'hf,4'hf,4'hf,
                           4'hf,4'h9,4'h4,4'h2,
                           4'h1,4'h0,4'hf,4'h5};

    assign CCL_count_sq = {4'h2,4'h5,4'h1,4'h0};
    assign bit          = {8'h2d,8'hf1,8'h41,8'h9d,8'hcc,
                           8'hd5,8'h50,8'h01,8'hcf,8'hd9};

    always @(posedge clk) begin
        if(!rst_n) pointer <= 7'b0;
        else pointer <= pointer + ((fetch&fetch_musk)?1'b1:1'b0);
    end

    always @(*) begin
        fetch = (bit_req&(pointer <= 7'd79)) | (pointer == 7'd0);
    end

    always begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end

    always begin
        fetch_musk = 1;
        #20;
        fetch_musk = 0;
        #20;
    end

    always begin
        #10;
        wfull_musk = 1;
        #20;
        wfull_musk = 0;
        #20;
    end
endmodule