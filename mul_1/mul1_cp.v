module mul1_cp(ldA,ldB,ldP,clrP,decB,done,eqz,start,clk,reset);
	input start,clk,eqz,reset;
	output reg ldA,ldB,ldP,clrP,decB,done;
	
	reg [2:0] PS,NS;
	parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100, S5=3'b101, S6=3'b110, S7=3'b111 ;
	
	always @(posedge clk)
		begin
			#1
			if(reset) PS <= S0; 
			else PS <= NS;
		end
	
	always @(PS,eqz,start)
		begin
			case(PS)
				S0:
					begin
						#1 ldA = 0; ldB = 0; ldP = 0; clrP = 0; decB = 0; done = 0;
						#1 NS = start ? S1 : S0 ;
					end
				S1: 
					begin
						#1 ldA = 1;
						NS = S2;
					end	
				S2:
					begin
						#1 ldA = 0; ldB = 1; clrP = 1;
						NS = S3;
					end
				S3: 
					begin
						#1 ldB = 0; clrP = 0; ldP = 1; decB = 1;
						NS = eqz ? S4 : S3 ;
					end
				S4:
					begin
						#1 done = 1; ldP = 0; decB = 0;
						NS = S4;
					end
				S5:
					begin
						#1 ldA = 0; ldB = 0; ldP = 0; clrP = 0; decB = 0; done = 0;
						NS = S0;
					end
				S6: 
					begin
						#1 ldA = 0; ldB = 0; ldP = 0; clrP = 0; decB = 0; done = 0;
						NS = S0;
					end
				S7: 
					begin
						#1 ldA = 0; ldB = 0; ldP = 0; clrP = 0; decB = 0; done = 0;
						NS = S0;
					end
				default: 
					begin
					#1 ldA = 0; ldB = 0; ldP = 0; clrP = 0; decB = 0; done = 0;
					NS = S0;
					end
			endcase
		end
endmodule