`timescale 1ns / 1ps

module adder4bit (
    input wire [3:0]inA,
    input wire [3:0]inB,
    //input wire cin,
    output wire [3:0]s
    //output wire cout
);
    //wire c[4:0];
    assign s=inA+inB;
endmodule
