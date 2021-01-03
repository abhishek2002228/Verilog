module test_edge();
	reg clk, rst, lvl;
	wire edge_tick;
	
	edge_detector_mealy A(clk,rst,lvl,edge_tick);
	
	always #5 clk = ~clk ;
	
	initial
		begin
		clk = 1'b0;
		rst = 1'b1;
		lvl = 1'b0;
		
		@(negedge clk);
		rst = 1'b0;
		
		repeat(5) @(negedge clk);
		
		lvl = 1'b1 ;
		repeat(5) @(negedge clk);
		
		lvl = 1'b0;
		@(negedge clk);
		lvl = 1'b1;
		
		@(negedge clk)
		lvl = 1'b0;
		repeat(2) @(negedge clk);
		lvl = 1'b1;	

		@(negedge clk)
		rst = 1'b1;
		lvl = 1'b0;
		
		#30 $finish;
		end
		
	initial
		begin
		$dumpfile("edge_detector_mealy.vcd");
		$dumpvars(0,test_edge);
		end
endmodule		