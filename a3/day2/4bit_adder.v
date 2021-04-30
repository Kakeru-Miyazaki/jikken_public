`timescale 1ns / 1ps

module adder4bit (
    input wire [3:0]inA,
    input wire [3:0]inB,
    output wire [3:0]s
);

    assign s=inA+inB;
endmodule
