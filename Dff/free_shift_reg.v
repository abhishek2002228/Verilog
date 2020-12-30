module free_shift_reg
	#(parameter N = 8)
	(
		input wire clk, rst,
		input wire serial_in,
		output wire serial_out
	);
	
	reg [N-1 : 0] r_reg; 
	wire [N-1 : 0] r_next;
	
	always @(posedge clk)
		r_reg <= r_next ;
	
	assign r_next = rst? 0:{serial_in,r_reg[N-1:1]} ;
	assign serial_out = r_reg[0] ;
endmodule 