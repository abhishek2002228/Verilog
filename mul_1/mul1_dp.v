module mul1_dp(eqz,ldA,ldB,ldP,clrP,decB,d_in,clk);
	output eqz;
	input ldA,ldB,ldP,clrP,decB,clk;
	input [15:0] d_in;
	
	wire [15:0] bus, X, Y, Z, Bout;
	assign bus = d_in;
	
	PIPO1 A (X,bus,ldA,clk);
	PIPO2 P (Y,bus,ldP,clrP,clk);
	CNTR B (Bout,bus,ldB,decB,clk);
	ADD AD (Z,X,Y);
	COMP EQZ(eqz,Bout);
endmodule
	