`timescale 1ns / 100ps

module ALU(A,B,OP,C,Cout);

	input [15:0]A;
	input [15:0]B;
	input [3:0]OP;
	output [15:0]C;
	output Cout;

	//TODO
	always @(*) begin
		case (OP)
			// !Arithmetic
			OP_ADD: begin
				{Cout,C}=A+B
			end
			OP_SUB: begin
				//TODO
			end
			// !Bitwise Boolean operation
			OP_AND: begin
				{Cout,C}=A&B;
			end
			OP_OR: begin
				//TODO
			end
			OP_NAND: begin
				{Cout,C}=A~&B;
			end
			OP_NOR: begin
				//TODO
			end
			OP_XOR: begin
				{Cout,C}=A^B;
			end
			OP_XNOR: begin
				//TODO
			end
			// !Logic
			OP_ID: begin
				{Cout,C}=A;
			end
			OP_NOT: begin
				//TODO
			end
			// !shift
			OP_LRS: begin
				{Cout,C}=A >> 1 ;
			end
			OP_ARS: begin
				//TODO
			end
			OP_RR: begin
				{Cout,C}=A[0]A[15:1] ;
			end
			OP_LLS: begin
				//TODO
			end
			OP_ALS: begin
			    {Cout,C}=A <<< 1 ;
			end
			OP_RL: begin
				//TODO
			end
		endcase
	end
	
endmodule
