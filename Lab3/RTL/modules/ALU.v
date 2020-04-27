module ALU(
	input  wire clk,
	input  wire rstn,
	input wire [31:0]A,
	input wire [31:0]B,
	input wire [3:0]OP,
	output reg [31:0]C,
	output reg Cout
);


	always @(*) begin
		case (OP)
			// !Arithmetic
			4'b0000: begin
				C=A+B;
				Cout = ( A == B ) ;
				//Add/BEQ
			end
			4'b0001: begin
				C = (A>=B)?(A-B):(~(B-A-32'h1));
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
				if (A<B)begin
					Cout=1;
					C=1;
				end
				else begin
					Cout=0;
					C=0;
				end
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
				C=0;
				Cout = 0;
				//JAL
			end
			// !shift
			4'b1010: begin
				C=A >> B ;
				//srl
			end
			4'b1011: begin 
				if(A<B)begin
					C=0;
				end
				else
					C=1;
				Cout = A + 4; 
				//JALR
			end
			4'b1100: begin
				if (A[31]==B[31])begin
					if (A[30:0]<B[30:0])begin
						C=32'b01;
						Cout=1;
					end
					else begin
						Cout=0;
						C=32'b00;
					end
				end
					
				if((A[31]==1) & (B[31]==0))begin
					C=32'b01;
					Cout=1;
				end
				if((A[31]==0) & (B[31]==1))begin
					C=32'b00;
					Cout=0;
				end
					
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
