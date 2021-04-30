`timescale 1ns / 1ps

module fulladder (
    input wire inA,
    input wire inB,
    input wire cin,
    output wire s,
    output wire c
);
    wire stmp;
    wire ctmp;
    wire ctmp2;
    
    halfadder halfadder_0 (
        .inA(inA),
        .inB(inB),
        .s(stmp),
        .c(ctmp)
    );
    
    halfadder halfadder_1 (
        .inA(stmp),
        .inB(cin),
        .s(s),
        .c(ctmp2)
    );
   
    assign c=ctmp|ctmp2;
endmodule
