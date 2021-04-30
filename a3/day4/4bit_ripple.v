`timescale 1ns / 1ps

module rippleadder4bit (
    input wire [3:0]inA,
    input wire [3:0]inB,
    output wire [3:0]s,
    output wire cout
);
    wire [4:0]c;
    assign c[0]=1'b0;
    generate 
        genvar i;
        for (i=0;i<4;i=i+1) begin
            fulladder fulladder(
                .inA(inA[i]),
                .inB(inB[i]),
                .cin(c[i]),
                .s(s[i]),
                .c(c[i+1])
            );
        end
    endgenerate
    assign cout = c[4];
endmodule
