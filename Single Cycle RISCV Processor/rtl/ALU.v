module ALU (ALU_Cntrl, In1, In2, Zero, ALU_Result);
	input wire [3:0] ALU_Cntrl;
	input wire [31:0] In1, In2;
	output reg [31:0] ALU_Result;
	output wire Zero;
	
	localparam [3:0] AND = 4'b0000, OR = 4'b0001, ADD = 4'b0010, SUB = 4'b0110;
	
	
	always @(*)
		begin
		case(ALU_Cntrl)
			AND: ALU_Result = In1 & In2;
			OR: ALU_Result = In1 | In2;
			ADD: ALU_Result	= In1 + In2;
			SUB: ALU_Result = In1 - In2;
			default: ALU_Result = 32'bx;
		endcase
		end
	
	assign Zero = (ALU_Result == 32'b0);
endmodule