module testbench;
    
    // parameter
    parameter CYCLE = 4; // clock cycle
    parameter HALF_CYCLE = 2; // half cycle
    parameter DLY = 2; // delay
    
    // wire/reg
    reg clk;
    reg start;
    wire out;


    // DUT module
    example2 example2_0 (
        .start(start),
        .clk(clk),
        .out(out)
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
        start = 4'd0;
        # 30;
    
        // for example2
        start = 4'd0;
        for (integer i=0;i<16;i=i+1) begin
            start = i%2;
            #25 $display("start=%b", start);        
        end
 
        
        repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
