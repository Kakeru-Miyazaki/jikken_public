`timescale 1ns / 1ps

module flipflop (
    input wire d,
    input wire clk,
    output q
);
    
    reg Q;
    
    always @(posedge d, negedge d, posedge clk, negedge clk) begin
        if (clk) begin
            Q <= d;        
        end
    end
    
    assign q = Q;

endmodule
