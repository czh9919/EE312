`timescale 1ns / 100ps

module ALU(A,B,OP,C,Cout);

	input [15:0]A;
	input [15:0]B;
	input [3:0]OP;
	output [15:0]C;
	output Cout;

	reg [15:0]C;
	reg Cout;
	reg temp;
	always @(*) begin
		case (OP)
			// !Arithmetic
			4'b0000: begin
				C=A[14:0]+B[14:0];
				temp=C[15];
				{Cout,C[15]}=C[15]+A[15]+B[15];
				Cout=Cout^temp;
			end
			4'b0001: begin
				C = (A>=B)?(A-B):(~(B-A-16'h1));
				Cout = 0;
			end
			// !Bitwise Boolean operation
			4'b0010: begin
				{Cout,C}=A&B;
			end
			4'b0011: begin
				C = A|B;
				Cout=0;
			end
			4'b0100: begin
				C=~(A&B);
				Cout=0;
			end
			4'b0101: begin
				C = ~(A | B);
				Cout=0;
			end
			4'b0110: begin
				{Cout,C}=A^B;
			end
			4'b0111: begin
				C = A ^~ B;
				Cout=0;
			end
			// !Logic
			4'b1000: begin
				{Cout,C}=A;
			end
			4'b1001: begin
				C = ~A;
				Cout = 0;
			end
			// !shift
			4'b1010: begin
				{Cout,C}=A >> 1 ;
			end
			4'b1011: begin 
				C ={A[15],A[15:1]};
				Cout = 0;
			end
			4'b1100: begin
				C={A[0],A[15:1]} ;
				Cout = 0;
			end
			4'b1101: begin
				C = A <<1;
				Cout = 0;
			end
			4'b1110: begin
			    C=A <<< 1 ;
				Cout=0;
			end
			4'b1111: begin
				C = {{A[14:0]},{A[15]}};
				Cout=0;
			end
		endcase
	end
	
endmodule
