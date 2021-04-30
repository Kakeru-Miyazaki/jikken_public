`timescale 1ns / 1ps

module halfadder (
    input wire inA,
    input wire inB,
    output wire s,
    output wire c
);
    assign s = (inA^inB);
    assign c = (inA & inB);



endmodule
