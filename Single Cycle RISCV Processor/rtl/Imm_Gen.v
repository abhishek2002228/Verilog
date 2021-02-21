module Imm_Gen(instr, Imm_out, Imm_sel);
	input wire [31:0] instr;
	input wire [1:0] Imm_sel;
	output wire [31:0] Imm_out;
	
	reg [11:0] Imm_intermediate ;
	
	localparam [2:0] R_type = 2'bxx, I_type = 2'b00, S_type = 2'b01, B_type = 2'b10 ;
	
	always @(*)
		case(Imm_sel)
			I_type: Imm_intermediate = instr[31:20];
			S_type: Imm_intermediate = {instr[31:25],instr[11:7]};
			B_type: Imm_intermediate = {instr[31],instr[7],instr[30:25],instr[11:8]};
			default: Imm_intermediate = 12'bx;
		endcase
		
	assign Imm_out = {{20{Imm_intermediate[11]}}, Imm_intermediate[11:0]};		
endmodule
