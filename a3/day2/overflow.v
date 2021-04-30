`timescale 1ns / 1ps

module overflow (
    input wire [3:0]inA,
    input wire [3:0]inB,
    output wire [4:0]s1,
    output wire [3:0]s2,
    output wire cout
);
    assign s1 = inA+inB;
    
    rippleadder4bit rippleadder4bit(
        .inA(inA),
        .inB(inB),
        .s(s2),
        .cout(cout)
    );
endmodule
