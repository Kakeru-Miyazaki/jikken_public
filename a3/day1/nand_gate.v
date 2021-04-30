`timescale 1ns / 1ps

module nand_gate (
    input wire inA,
    input wire inB,
    output wire out
);

    assign out = !(inA & inB);


endmodule
