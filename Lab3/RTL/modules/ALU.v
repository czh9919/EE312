0module ALU(

	input wire [31:0]A,
	input wire [31:0]B,
	input wire [4:0]OP,
	output reg [31:0]C,
	output reg Cout
);
	reg temp;
	always @(*) begin
		case (OP)
			// !Arithmetic
			5'b00000: begin
				C=A+B;
				Cout = ( A == B ) ;
				//Add/BEQ
			end
			5'b00001: begin
				C = (A>=B)?(A-B):(~(B-A-32'h1));
				//sub
				Cout = 0;
			end
			// !Bitwise Boolean operation
			5'b00010: begin
				C=A & B;
				Cout=0;
				//and
			end
			4'b00011: begin
				C = A|B;
				//or
				Cout=0;
			end
			4'b00100: begin
				if (A<B)
					Cout=1;
				else
					Cout=0;
				//sltu
			end
			4'b00101: begin
				C = A << B;
				Cout=0;
				//SLL
			end
			4'b00110: begin
				C=A^B;
				//xor
				Cout=0;
			end
			4'b00111: begin
				C = A >>> B;
				Cout=0;
				//SRA
			end
			// !Logic
			4'b01000: begin
				C=A+(B<<12);
				Cout=0;
				//ALUPC
			end
			4'b01001: begin
				C=0;
				Cout = 0;
				//JAL
			end
			// !shift
			4'b01010: begin
				C=A >> B ;
				//srl
			end
			4'b01011: begin 
				C = A + 4; 
				//JALR
			end
			4'b01100: begin
				if (A[0]==B[0])
					if (A[4:1]<B[4:1])
						Cout=1;
				if((A[0]==1) & (B[0]==0))
					Cout=1;
				if((A[0]==0) & (B[0]==1))
					Cout=0;
				//SLT
			end
			4'b01101: begin
				C = A <<12;
				Cout = ( A < B ); 
				//LUI
			end
			4'b01110: begin
				Cout= ( A != B ) ;
				//BNE
			end
			4'b01111: begin
				
				Cout= ( A >=B) ;
				//BGE/BLT
			end
		endcase
	end

endmodule
