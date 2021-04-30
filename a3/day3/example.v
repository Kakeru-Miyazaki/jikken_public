`timescale 1ns / 1ps

module example (
    input wire inA,
    input wire clk,
    output wire out1,
    output wire out2
);

    reg out1_reg, out2_reg;


    always @(posedge clk) begin
        out1_reg <= inA;
    end

    always @(*) begin
        out2_reg <= inA;
    end

    assign out1 = out1_reg;
    assign out2 = out2_reg;

endmodule
