module testbench;
    
    // parameter
    parameter CYCLE = 4; // clock cycle
    parameter HALF_CYCLE = 2; // half cycle
    parameter DLY = 2; // delay
    
    // wire/reg
    reg clk;
    reg start;
     reg rst;
    wire out;



    // DUT module
    example3 example3_0 (
        .start(start),
        .rst(rst),
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
        rst = 0;
        #30;
        // for example3
        start = 4'd0;
        for (integer i=0;i<16;i=i+1) begin
            start = i%4;
            if (i%3 == 1) begin
                #5;
                rst = 1'b1;
            
            end else begin
                #5;
                rst = 1'b0;
            end
            #7 $display("start=%b", start);
        end
 
        
        repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
