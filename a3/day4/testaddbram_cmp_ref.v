module testbench;
    
    // parameter
    parameter CYCLE = 5; // clock cycle
    parameter HALF_CYCLE = 2.5; // half cycle
    parameter DLY = 2.5; // delay
    
    
    reg clk;
    wire [3:0] out;
    wire over;
    reg [3:0] ref [30:0];
    reg [3:0] ans;
    integer count;
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
        
        ans <= ref[count];
        if (ans!=out) begin
            $display("address=%d", count);
        end        
        count <= count+1;
    
    end
    // test scenario
    initial begin
        // initialize
        count = 0;
        $readmemh("/home/denjo/3s/jikken/private/a3/day4/myfiles/ref.hex", ref);
        
        repeat(31) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
