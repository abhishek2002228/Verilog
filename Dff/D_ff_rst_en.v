module d_ff_en(Q,D,clk,rst,en);
	input wire D,clk,rst,en ;
	output reg Q;
	
	always@(posedge clk)
		if(rst)
			Q <= 1'b0 ;
		else if(en)
			Q <= D ;
endmodule 
// used for gated clock signals
// if clk = 50 Hz and you want 1 Hz, activate enable onece every 50 clock cycles , 