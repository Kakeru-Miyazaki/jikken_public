module testbench;
    
    // parameter
    parameter CYCLE = 5; // clock cycle
    parameter HALF_CYCLE = 2.5; // half cycle
    parameter DLY = 2.5; // delay
    
    
    reg clk;
    wire [3:0] out;
    wire over;

    // DUT module
    addbram addbram_0 (
        .clk(clk),
        .out(out),
        .over(over)
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
        #1 $display("mem=%b", out);

    
        repeat(31) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
