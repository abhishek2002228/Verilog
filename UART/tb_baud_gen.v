`timescale 1ns/1ps

module tb_baud_gen();
	parameter N = 8;
	reg clk, rst;
	wire s_tick;
	wire [N-1:0] q;
	
	always #10 clk = ~clk;
	
	baud_gen A(s_tick,q,clk,rst);
	
	initial
		begin
		clk = 1'b0;
		rst = 1'b1;
		@(negedge clk);
		rst = 1'b0;
		repeat(1000) @(negedge clk);
		$finish;
		end
	
	initial
		begin
		$dumpfile("baud_gen.vcd");
		$dumpvars(0,tb_baud_gen);
		end
		
endmodule