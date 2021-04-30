module testbench;
    
    // parameter
    parameter CYCLE = 100; // clock cycle
    parameter HALF_CYCLE = 50; // half cycle
    parameter DLY = 50; // delay
    
    // wire/reg
    reg clk;
    reg rst;
    wire D;
    wire Qout_flipflop;

    // DUT module
    flipflop flipflop_0 (
        .d_0(1'b0),
        .rst(rst),
        .clk(clk),
        .d(D),
        .q(Qout_flipflop)
    );

    // clock generator
    always begin
        clk = 1'b1;
        #(HALF_CYCLE) clk = 1'b0;
        #(HALF_CYCLE);
    end

    // test scenario
    initial begin
        // initialize
        rst = 1'b0;
        
        // for flipflop
        #100 $display("D=%b rst=%b out=%b", D, rst, Qout_flipflop);
        rst = 1'b1;
        #150 $display("D=%b rst=%b out=%b", D, rst, Qout_flipflop);  
        rst = 1'b0;

        repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule