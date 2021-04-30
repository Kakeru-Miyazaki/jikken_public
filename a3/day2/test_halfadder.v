module testbench;
    
    // parameter
    parameter CYCLE = 1000; // clock cycle
    parameter HALF_CYCLE = 500; // half cycle
    parameter DLY = 500; // delay
    
    // wire/reg
    reg clk;
    reg inA, inB;
    wire s;
    wire c;

    // DUT module
    halfadder halfadder_0 (
        .inA(inA),
        .inB(inB),
        .s(s),
        .c(c)
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
        inA = 1'b0; inB = 1'b0;
        
        // for halfadder
        inA = 1'b0; inB = 1'b0;
        #200 $display("inA=%b inB=%b s=%b c=%b", inA, inB, s,c);
        inA = 1'b1; inB = 1'b0;
        #200 $display("inA=%b inB=%b s=%b c=%b", inA, inB, s,c);
        inA = 1'b0; inB = 1'b1;
        #200 $display("inA=%b inB=%b s=%b c=%b", inA, inB, s,c);  
        inA = 1'b1; inB = 1'b1;
        #200 $display("inA=%b inB=%b s=%b c=%b", inA, inB, s,c);

        repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
