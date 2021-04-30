`timescale 1ns / 1ps

// Block RAM (Read-First mode) example code 
// For more information, please refer to Xilinx UG473 and UG687
// UG473: https://japan.xilinx.com/support/documentation/user_guides/j_ug473_7Series_Memory_Resources.pdf
// UG687: https://japan.xilinx.com/support/documentation/sw_manuals_j/xilinx14_7/xst_v6s6.pdf

module addbram ( 
    input wire  clk,
    output wire [3:0] out,
    output wire over
);

    reg [3:0] mem [0:31];
    wire [3:0] mem_out [0:30];
    wire [0:30] mem_over;
    reg [3:0] mem_out_forwire;
    reg mem_over_forwire;
    integer i;

    
    generate
        genvar k;
        for (k = 0; k < 31; k = k+1) begin
            rippleadder4bit rippleadder4bit(
                .inA(mem[k]),
                .inB(mem[k+1]),
                .s(mem_out[k]),
                .cout(mem_over[k])
            );
        end
    endgenerate
    initial begin
        $readmemh("/home/denjo/3s/jikken/private/a3/day4/myfiles/mem.hex", mem);
        i = -1;
    end
    always @(posedge clk) begin
        if (i < 31) begin
        mem_out_forwire <= mem_out[i];
        mem_over_forwire <= mem_over[i];
        end 
        i <= i+1;
    end

    assign out = mem_out_forwire;
    assign over = mem_over_forwire;
endmodule