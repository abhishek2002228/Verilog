`timescale 1ns/1ns

module test_decoder();
	wire out;
	reg [3:0] mux_in;
	reg [1:0] sel;
	
	decoder A(out, mux_in, sel);
	
	initial begin
		mux_in = 4'b1001 ;
		#5 sel=2'b00;
		#5 sel=2'b01;
		#5 sel=2'b10;
		#5 sel=2'b11;
		#10 $finish;
	end
	
	initial begin
		$dumpfile("decoder.vcd"); $dumpvars(0,test_decoder);
		$monitor($time," %b ",out);
	end
endmodule