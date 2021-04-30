`timescale 1ns / 1ps

module example3 (
    input wire start,
    input wire rst,
    input wire clk,
    output wire out
);
    reg [1:0] k;
    reg started;
    reg storage_start;
    initial begin
        k = 1;
        started = 0;
    end
    always @(posedge clk, posedge rst) begin
        storage_start = start;
        if (rst == 1) begin
            started = 1;
            k=0;
        end else begin
            if (storage_start == 1) begin
                k = 0;
                started = 1;
            end else begin
                if (started == 1)
                    k = k + 1;
            end
        end
    end
    assign out = (k == 0)? 1 : 0;


endmodule
