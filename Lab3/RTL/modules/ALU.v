module ALU(
	input  wire clk,
	input  wire rstn,
	input wire [31:0]A,
	input wire [31:0]B,
	input wire [4:0]OP,
	output reg [31:0]C
);


	always @(*) begin
		case (OP)
			// !Arithmetic
			5'b0000: begin
				C=A+B;
				//Add/BEQ
			end
			5'b0001: begin
				C = (A>=B)?(A-B):(~(B-A-32'h1));
				//sub
			end
			// !Bitwise Boolean operation
			5'b0010: begin
				C=A & B;
				//and
			end
			5'b0011: begin
				C = A|B;
				//or
			end
			5'b0100: begin
				if (A<B)begin
					C=1;
				end
				else begin
					C=0;
				end
				//sltu
			end
			5'b0101: begin
				C = A << B;
				//SLL
			end
			5'b0110: begin
				C=A^B;
				//xor
			end
			5'b0111: begin
				C = A >>> B;
				//SRA
			end
			// !Logic
			5'b1000: begin
				C=A+(B<<12);
				//ALUPC
			end
			5'b1001: begin
				if (A[31]==B[31])begin
					if (A[30:0]>=B[30:0])begin
						C=1;
					end
					else begin
						C=0;
					end
				end	
				if((A[31]==1) & (B[31]==0))begin
					C=0;
				end
				if((A[31]==0) & (B[31]==1))begin
					C=0;
				end
			end
			// !shift
			5'b1010: begin
				C=A >> B ;
				//srl/BGE
			end
			5'b1011: begin 
				if(A<B)begin
					C=0;
				end
				else
					C=1;
				//JALR
			end
			5'b1100: begin
				if (A[31]==B[31])begin
					if (A[30:0]<B[30:0])begin
						C=32'b01;
					end
					else begin
						C=32'b00;
					end
				end
					
				if((A[31]==1) & (B[31]==0))begin
					C=32'b01;
				end
				if((A[31]==0) & (B[31]==1))begin
					C=32'b00;
				end
					
				//BLT
			end
			5'b1101: begin
				C = A <<12;
				//BLTU
			end
			5'b1110: begin
				C= ( A != B ) ;
				//BNE
			end
			5'b1111: begin
				
				C= ( A >=B) ;
				//BGEU
			end
			5'b10000:
				C=(A==B);
		endcase
	end

endmodule
