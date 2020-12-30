module decoder(out, mux_in, sel);
	input [1:0] sel;
	input [3:0] mux_in;
	output reg out;
	
	always @*
		begin
			casez(sel)
				2'b0? : out = |mux_in ;
				2'b1? : out = ^mux_in ;
			endcase
		end
endmodule 