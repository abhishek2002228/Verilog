module test_mul1();

	reg [15:0] d_in;
	reg start, clk, reset;
	wire done, eqz, ldA, ldB, decB, clrP, ldP;
	
	mul1_dp dp(eqz,ldA,ldB,ldP,clrP,decB,d_in,clk);
	mul1_cp cp(ldA,ldB,ldP,clrP,decB,done,eqz,start,clk,reset);
	
	initial begin
		clk = 1'b0;
		reset = 1'b1;
		#7 reset = 1'b0;
		#3 start = 1'b1;
		#1000 $finish;
	end
	
	always #5 clk = ~clk ;
	
	initial begin
		#10 d_in = 17;
		#17 d_in = 5;
	end
	
	initial begin
		$dumpfile("mul1.vcd"); $dumpvars(0,test_mul1);
		$monitor($time," %d %b %d", dp.Y, done, cp.PS);
	end
	
endmodule