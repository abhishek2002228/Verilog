module disp_mux
	(
		input wire rst, clk,
		input wire [7:0] in0, in1, in2, in3,
		output reg [7:0] sseg,
		output reg [3:0] an
	);
	
	localparam N = 18; //for setting the refresh rate , higher the number , lower the frequency
	// refresh rate = clock frequency / 2^(N-2)
	reg [N-1:0] q_reg;
	wire [N-1:0] q_next;
	wire [1:0] sel;
	
	always @(posedge clk, posedge rst)
		if(rst) q_reg <= 0 ;
		else q_reg <= q_next ;
	
	assign q_next = q_reg + 1;
	assign sel = q_reg[N-1:N-2] ;
	
	always @*
		begin
			case(sel)
				2'b00: 
					begin
						sseg = in0;
						an = 4'b1110;
					end
				2'b01: 
					begin
						sseg = in1;
						an = 4'b1101;
					end
				2'b10: 
					begin
						sseg = in2;
						an = 4'b1011;
					end
				2'b11: 
					begin
						sseg = in3;
						an = 4'b0111;
					end
			endcase
		end
endmodule