`timescale 1ns / 100ps

module ALU(A,B,OP,C,Cout);

	input [15:0]A;
	input [15:0]B;
	input [15:0]D;
	input [5:0]OP;
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
				Cout=Cout^temp;//Add
			end
			4'b0001: begin
				C = (A>=B)?(A-B):(~(B-A-16'h1));
				//sub
				Cout = 0;
			end
			// !Bitwise Boolean operation
			4'b0010: begin
				{Cout,C}=A & B;
				//and
			end
			4'b0011: begin
				C = A|B;
				//or
				Cout=0;
			end
			4'b0100: begin
				if (A<B)
					C=1;
				else
					C=0;
				//slt
			end
			4'b0101: begin
				C = A << B;
				Cout=0;
				//SLL
			end
			4'b0110: begin
				C=A^B;
				//xor
				cout=0;
			end
			4'b0111: begin
				C = A >>> B;
				Cout=0;
				//SRA
			end
			// !Logic
			4'b1000: begin
				C=A+(B<<12);
				cout=0;
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
				A = ( B + D ) & 0xfffffffe;
				Cout = 0;
				//JALR
			end
			4'b1100: begin
				C={A[0],A[15:1]} ;
				Cout = 0;
			end
			4'b1101: begin
				C = A <<12;
				Cout = 0;
				//LUI
			end
			4'b1110: begin
			    C = ( A == B ) ? C + D : C + 4;
				Cout= ( A != B ) ? C + D : C + 4;
				//BEQ/BNE
			end
			4'b1111: begin
				C = ( A < B ) ? C + D : C + 4
				Cout= ( A >=B) ? C + D : C + 4;
				//BGE/BLT
			end
		endcase
	end
	
endmodule
