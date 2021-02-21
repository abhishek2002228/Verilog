module ALU_Control_Unit (ALU_Op, funct3, funct7, ALU_Cntrl);
	
	input wire [1:0] ALU_Op;
	input wire [2:0] funct3;
	input wire [6:0] funct7;
	output reg [3:0] ALU_Cntrl;
	
	localparam [1:0] R_type = 2'b10, IS_type = 2'b00, B_type = 2'b01;
	
	localparam [3:0] ADDsig = 4'b0000, SUBsig = 4'b1000, ANDsig = 4'b0111, ORsig = 4'b0110;
	
	localparam [3:0] AND = 4'b0000, OR = 4'b0001, ADD = 4'b0010, SUB = 4'b0110;
	
	wire [3:0] funct = {funct7[5],funct3};
	
	always @(*)
		begin
		if(ALU_Op == R_type)
			begin
			case(funct)
				ADDsig: ALU_Cntrl = ADD;
				SUBsig: ALU_Cntrl = SUB;
				ORsig: ALU_Cntrl = OR;
				ANDsig: ALU_Cntrl = AND;
				default: ALU_Cntrl = 4'bx;
			endcase				
			end
		else if(ALU_Op == IS_type)
			begin
			ALU_Cntrl = ADD;
			end
		else if(ALU_Op == B_type)
			begin
			ALU_Cntrl = SUB;
			end
		else
			begin
			ALU_Cntrl = 4'bx;
			end
		end
endmodule