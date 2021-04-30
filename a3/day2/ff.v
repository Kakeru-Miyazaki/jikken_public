`timescale 1ns / 1ps

module flipflop (
    input wire d_0,
    input wire rst,
    input wire clk,
    output d,
    output q
);
    
    reg Q;
    reg D;
    initial begin
        Q <= q;
        D <= d_0;
    end
    always @(posedge clk,posedge rst) begin
        if (rst) begin 
            Q <= 1'b0;
            D <= ~Q;
        end else begin
            Q <= ~Q;
            D <= ~D;
        end
    end
    assign q = Q;
    assign d = D;
endmodule
