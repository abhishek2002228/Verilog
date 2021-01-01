module test_fifo();
	reg clk, rst, rd, wr;
	reg [7:0] buf_in;
	wire empty, full;
	wire [7:0] buf_out;
	wire [6:0] fifo_cntr;
	integer i;
	
	fifo_single_clock A(fifo_cntr,empty,full,buf_out,buf_in,rst,wr,rd,clk);
	
	always #5 clk = ~clk;
	
	initial 
		begin
		for(i = 0; i< 30; i = i + 1)
			begin
			@(negedge clk);
			buf_in = i ;
			end
		buf_in = 8'd0;
		repeat(7) @(negedge clk);
		for(i = 30; i < 69; i = i + 1)
			begin
			@(negedge clk);
			buf_in = i;
			end
		end
		
	
	
	initial 
		begin
		clk = 1'b0;
		rst = 1'b1;
		rd = 1'b0;
		wr = 1'b0;
		@(negedge clk);
		rst = 1'b0;
		wr = 1'b1;
		repeat(29) @(negedge clk);
		wr = 1'b0;
		rd = 1'b1;
		repeat(5) @(negedge clk);
		wr  = 1'b1;
		repeat(2) @(negedge clk);
		rd = 1'b0;
		repeat(45) @(negedge clk);
		wr=1'b0;
		rst = 1'b1;
		@(negedge clk);
		#3 $finish;
		end
	initial
		begin
		$dumpfile("fifo.vcd");
		$dumpvars(0,test_fifo);
		end
endmodule
		