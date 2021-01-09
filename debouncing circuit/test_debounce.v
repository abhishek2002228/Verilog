module test_debounce();
	reg clk, sw, rst;
	wire db_level, db_tick;
	
	wire q_zero, load, dec;
	
	datapath A(q_zero,load,dec,rst,clk);
	controlpath B(load,dec,db_tick,db_level,sw,q_zero,clk,rst);
	
	always #5 clk = ~clk;
	
	initial
		begin
		clk = 1'b0;
		rst = 1'b1;
		sw = 1'b0;
		
		@(negedge clk);
		
		rst = 1'b0;
		sw = 1'b1;
		
		repeat(11) @(negedge clk);
		
		sw = 1'b0;
		
		repeat(15) @(negedge clk);

		$finish;
		end
	
	initial
		begin
		$dumpfile("debounce.vcd");
		$dumpvars(0,test_debounce);
		end
endmodule