`timescale 1ns / 1ps

module adv (
	input wire clk,
	input wire start,
	output reg a1,
	output reg a2,
	output reg b1,
	output reg b2
);

	reg a1,a2,b1,b2;
	
	initial begin
		a1 <= 0;
		a2 <= 1;
		b1 <= 0;
		b2 <= 1;
	end

	always @(posedge clk) begin
	   if (start== 1) begin
		a1 <= a2;
		a2 <= a1;
		b1 = b2;
		b2 = b1;	
		end
	end
endmodule
	
	
