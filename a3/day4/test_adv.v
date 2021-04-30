module testbench;
    
    // parameter
    parameter CYCLE = 10; // clock cycle
    parameter HALF_CYCLE = 5; // half cycle
    parameter DLY = 5; // delay
    
    // wire/reg
    reg clk;
    reg start;
    wire outa1,outa2,outb1,outb2;

    // DUT module
    adv adv (
        .clk(clk),
        .start(start),
        .a1(outa1),
        .a2(outa2),
        .b1(outb1),
        .b2(outb2)
    );

    // clock generator
    always begin
        clk = 1'b1;
        #(HALF_CYCLE) clk = 1'b0;
        #(HALF_CYCLE);
    end

    // test scenario
    initial begin
        #30
        start = 1;
       repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
