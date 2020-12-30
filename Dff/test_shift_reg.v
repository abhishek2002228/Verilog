module test_fsr();

	reg clk, rst, serial_in;
	wire serial_out ;
	
	free_shift_reg A(clk, rst, serial_in, serial_out);
	
	always #5 clk = ~clk ;
	
	initial begin
		clk = 1'b0 ;
		serial_in = 1'b1;
		rst = 1'b1 ;
		
		#77 rst = 1'b 0;
		
		#35 serial_in = 1'b0 ;
		
		#500 $finish ;
	end
	
	initial begin
		$dumpfile("free_shift_reg.vcd"); $dumpvars(0,test_fsr);
	end
endmodule