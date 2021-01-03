module priority_encoder
	(	input wire [4:1] r;
		output reg [2:0] y;
	);
	
	always @(*)
		if(r[4] == 1'b1) y=3'b100;
		else if(r[3] == 1'b1) y = 3'b011;
		else if(r[2] == 1'b1) y = 3'b010;
		else if(r[1] == 1'b1) y = 3'b001;
		else y = 3'b000;
	
endmodule
	
	
	