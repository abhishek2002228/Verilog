`timescale 1ns/1ps

module tb_rx();
	reg clk, rst,rx;
	wire s_tick, rx_done;
	wire [7:0] dout;
	wire [7:0] q;
	
	baud_gen A(s_tick,q,clk,rst);
	rx B(dout,rx_done,s_tick,rx,clk,rst);
	
	always #10 clk = ~clk;
	
	initial
		begin
		clk = 1'b0;
		rst = 1'b1;
		rx = 1'b1;
		@(negedge clk);
		rst = 1'b0;
		rx = 1'b0;
		#52083.333;
		rx =1'b1;
		#52083.333;
		rx =1'b0;
		#52083.333;
		rx =1'b1;
		#52083.333;
		rx =1'b0;
		#52083.333;
		rx =1'b1;
		#52083.333;
		rx =1'b0;
		#52083.333;
		rx =1'b1;
		#52083.333;
		rx =1'b0;
		#52083.333;
		rx = 1'b1;
		
		#52083.333;
		rx = 1'b0;
		#52083.333;
		rx =1'b0;
		#52083.333;
		rx =1'b1;
		#52083.333;
		rx =1'b0;
		#52083.333;
		rx =1'b1;
		#52083.333;
		rx =1'b0;
		#52083.333;
		rx =1'b1;
		#52083.333;
		rx =1'b0;
		#52083.333;
		rx =1'b1;
		#52083.333;
		rx = 1'b1;
		#52083.333;
		
		$finish;
		end
	initial
		begin
		$dumpfile("rx.vcd");
		$dumpvars(0,tb_rx);
		end
endmodule