module testbench;
    
    // parameter
    parameter CYCLE = 1000; // clock cycle
    parameter HALF_CYCLE = 500; // half cycle
    parameter DLY = 500; // delay
    
    // wire/reg
    reg clk;
    reg [3:0]inA;
    reg [3:0]inB;
    wire c;
    wire [3:0]s;

    // DUT module
    rippleadder4bit rippleadder4bit_0 (
        .inA(inA),
        .inB(inB),
        .s(s),
        .cout(c)
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
        inA = 4'd0; inB = 4'd0;
        
        // for rippleadder4bit
        inA = 4'd0; inB = 4'd0;
        for (integer i=0;i<16;i=i+1) begin
            for (integer j=0;j<16;j=j+1) begin
                inA = i;inB = j;
                #3 $display("inA=%b inB=%b  s=%b c=%b", inA, inB,s,c);
            end
        end
        
        repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
