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
				//TODO
			end
			OP_SUB: begin
				//TODO
			end
			// !Bitwise Boolean operation
			OP_AND: begin
				//TODO
			end
			OP_OR: begin
				//TODO
			end
			OP_NAND: begin
				//TODO
			end
			OP_NOR: begin
				//TODO
			end
			OP_XOR: begin
				//TODO
			end
			OP_XNOR: begin
				//TODO
			end
			// !Logic
			OP_ID: begin
				//TODO
			end
			OP_NOT: begin
				//TODO
			end
			// !shift
			OP_LRS: begin
				//TODO
			end
			OP_ARS: begin
				//TODO
			end
			OP_RR: begin
				//TODO
			end
			OP_LLS: begin
				//TODO
			end
			OP_ALS: begin
				//TODO
			end
			OP_RL: begin
				//TODO
			end
		endcase
	end
	
endmodule
