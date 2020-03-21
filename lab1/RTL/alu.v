`timescale 1ns / 100ps

module ALU(A,B,OP,C,Cout);

	input [15:0]A;
	input [15:0]B;
	input [3:0]OP;
	output [15:0]C;
	output Cout;

	always @(*) begin
		case (OP)
			// !Arithmetic
			OP_ADD: begin
				//TODO
			end
			OP_SUB: begin
				C = (A>B)?(A-B):(~(B-A));
				Cout = 0;
			end
			// !Bitwise Boolean operation
			OP_AND: begin
				//TODO
			end
			OP_OR: begin
				C = A|B;
				Cout=0;
			end
			OP_NAND: begin
				//TODO
			end
			OP_NOR: begin
				C = !(A | B);
				Cout=0;
			end
			OP_XOR: begin
				//TODO
			end
			OP_XNOR: begin
				C = A ^~ B;
				Cout=0;
			end
			// !Logic
			OP_ID: begin
				//TODO
			end
			OP_NOT: begin
				C = ~A;
				Cout = 0;
			end
			// !shift
			OP_LRS: begin
				//TODO
			end
			OP_ARS: begin
				C = A>>>1;
				Cout = 0;
			end
			OP_RR: begin
				//TODO
			end
			OP_LLS: begin
				C = A <<1;
				Cout = 0;
			end
			OP_ALS: begin
				//TODO
			end
			OP_RL: begin
				C = {{A[14:0]},{A[15]}}
			end
		endcase
	end
	
endmodule
