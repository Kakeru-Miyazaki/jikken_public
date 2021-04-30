module testbenchwithwrite;
    
    // parameter
    parameter CYCLE = 5; // clock cycle
    parameter HALF_CYCLE = 2.5; // half cycle
    parameter DLY = 2.5; // delay
    
    // wire/reg
    reg clk;
    reg we;
    reg [4:0] addr;
    reg [3:0] w_data;
    wire [3:0] r_data;

    // DUT module
    bram_example bram_example_0 (
        .clk(clk),
        .we(we),
        .addr(addr),
        .w_data(w_data),
        .r_data(r_data)
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
        we = 4'd0;
        
        // for bram_example
        for (integer i=0;i<40;i=i+1) begin
            addr <= i%32;
            if (i%5 == 0) begin
                w_data <= 0;
                we <= 1;
            end else begin
                we <= 0;
            end
            #10 $display("mem=%b", r_data);
        end
 
        
        repeat(10) @(posedge clk); // repeat 10 times
        $finish;
    end

endmodule
