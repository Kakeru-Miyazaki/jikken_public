module testbench;
    
    // parameter
    parameter CYCLE = 1000; // clock cycle
    parameter HALF_CYCLE = 500; // half cycle
    parameter DLY = 500; // delay
    
    // wire/reg
    reg clk;
    reg [3:0]inA;
    reg [3:0]inB;
    
    wire [4:0]s1;
    wire [3:0]s2;
    wire cout;

    // DUT module
    overflow overflow_0 (
        .inA(inA),
        .inB(inB),
        .s1(s1),
        .s2(s2),
        .cout(cout)
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
        
        // for overflow
        inA = 4'd0; inB = 4'd0;
        for (integer i=0;i<16;i=i+1) begin
            for (integer j=0;j<16;j=j+1) begin
                inA = i;inB = j;
                #3 $display("inA=%d inB=%d s1=%b s2=%d", inA, inB,s1,s2);
            end
        end
        
        repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
