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
				C=A+B;
				Cout = ( A == B ) ;
				//Add/BEQ
			end
			4'b0001: begin
				C = (A>=B)?(A-B):(~(B-A-16'h1));
				//sub
				Cout = 0;
			end
			// !Bitwise Boolean operation
			4'b0010: begin
				C=A & B;
				Cout=0;
				//and
			end
			4'b0011: begin
				C = A|B;
				//or
				Cout=0;
			end
			4'b0100: begin
				if (A<B)
					Cout=1;
				else
					Cout=0;
				//sltu
			end
			4'b0101: begin
				C = A << B;
				Cout=0;
				//SLL
			end
			4'b0110: begin
				C=A^B;
				//xor
				Cout=0;
			end
			4'b0111: begin
				C = A >>> B;
				Cout=0;
				//SRA
			end
			// !Logic
			4'b1000: begin
				C=A+(B<<12);
				Cout=0;
				//ALUPC
			end
			4'b1001: begin
				C=A+4;
				A=A+B;
				Cout = 0;
				//JAL
			end
			// !shift
			4'b1010: begin
				C=A >> B ;
				//srl
			end
			4'b1011: begin 
				C = A + 4; 
				//JALR
			end
			4'b1100: begin
				if (A[0]==B[0])
					if (A[4:1]<B[4:1])
						Cout=1;
				if((A[0]==1) & (B[0]==0))
					Cout=1;
				if((A[0]==0) & (B[0]==1))
					Cout=0;
				//SLT
			end
			4'b1101: begin
				C = A <<12;
				Cout = ( A < B ); 
				//LUI
			end
			4'b1110: begin
				Cout= ( A != B ) ;
				//BNE
			end
			4'b1111: begin
				
				Cout= ( A >=B) ;
				//BGE/BLT
			end
		endcase
	end
	
endmodule
