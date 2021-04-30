`timescale 1ns / 1ps

module example2 (
    input wire start,
    input wire clk,
    output wire out
);
    reg started;
    reg [1:0] k;
    reg storage_start;
    initial begin
        k <= 1; 
        started <= 0;
    end

    always @(posedge clk) begin
        storage_start = start;
        if (storage_start == 1) begin
            started = 1;
            k = 0;
        end else begin
            if (started == 1)
                k = k + 1;
        end
    end

    assign out = (k == 0)? 1 : 0;


endmodule
