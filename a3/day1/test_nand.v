module testbench;
    
    // parameter
    parameter CYCLE = 1000; // clock cycle
    parameter HALF_CYCLE = 500; // half cycle
    parameter DLY = 500; // delay
    
    // wire/reg
    reg clk;
    reg inA, inB;
    wire out_nand_gate;

    // DUT module
    nand_gate nand_gate_0 (
        .inA(inA),
        .inB(inB),
        .out(out_nand_gate)
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
        
        // for nand_gate
        inA = 1'b0; inB = 1'b0;
        #200 $display("inA=%b inB=%b out=%b", inA, inB, out_nand_gate);
        inA = 1'b1; inB = 1'b0;
        #200 $display("inA=%b inB=%b out=%b", inA, inB, out_nand_gate);  
        inA = 1'b0; inB = 1'b1;
        #200 $display("inA=%b inB=%b out=%b", inA, inB, out_nand_gate);  
        inA = 1'b1; inB = 1'b1;
        #200 $display("inA=%b inB=%b out=%b", inA, inB, out_nand_gate);

        repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
