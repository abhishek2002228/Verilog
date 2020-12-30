`timescale 1ns/1ns

module ALU_test();
	reg [15:0] X,Y;
	wire [15:0] Z;
	wire S,ZR,CY,P,V;
	
	ALU G1(.X(X),.Y(Y),.Z(Z),.Sign(S),.Parity(P),.Carry(CY),.Overflow(V),.Zero(ZR));
	
	initial 
		begin
			$dumpfile("ALU.vcd");
			$dumpvars(0,ALU_test);
			$monitor($time, "X=%h, Y=%h, Z=%h, S=%b, P=%b, CY=%b, V=%b, ZR=%b",X,Y,Z,S,P,CY,V,ZR);
			
			#5 X=16'h8fff; Y=16'h8000;
			#5 X=16'hfffe; Y=16'h0002;
			#5 $finish;
		end
endmodule