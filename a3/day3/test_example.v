module testbench;
    
    // parameter
    parameter CYCLE = 10; // clock cycle
    parameter HALF_CYCLE = 5; // half cycle
    parameter DLY = 5; // delay
    
    // wire/reg
    reg clk;
    reg inA;
    wire out1,out2;


    // DUT module
    example example_0 (
        .inA(inA),
        .clk(clk),
        .out1(out1),
        .out2(out2)
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
        inA = 4'd0;
        
        // for example
        inA = 4'd0;
        for (integer i=0;i<16;i=i+1) begin
            inA = i%2;
            #12 $display("inA=%b", inA);
        end
 
        
        repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
