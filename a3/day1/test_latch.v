module testbench;
    
    // parameter
    parameter CYCLE = 100; // clock cycle
    parameter HALF_CYCLE = 50; // half cycle
    parameter DLY = 50; // delay
    
    // wire/reg
    reg clk;
    //reg D, rst;
    reg d;
    wire Qout_flipflop;

    // DUT module
    flipflop flipflop_0 (
        .d(d),
        .clk(clk),
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
        //rst = 1'b0;
        d = 1'b0;
        // for flipflop
        //D = 1'b0; rst = 1'b0;
        #100 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b1;
        #25 $display("D=%b out=%b", d, Qout_flipflop);  
        d = 1'b0;
        #25 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b1;
        #25 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b0;
        
        #25 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b1;
        #25 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b0;
        #40 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b1;
        #25 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b0;
        #25 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b1;
        #25 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b0;
        
        #30 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b1;
        #70 $display("D=%b out=%b", d,Qout_flipflop);
        d = 1'b0;
        //#600 $display("D=%b rst=%b out=%b", D, rst, out_flipflop);  
        //D = 1'b1; rst = 1'b0;
        //#700 $display("D=%b rst=%b out=%b", D, rst, out_flipflop);

        repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule