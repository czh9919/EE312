module ALU(
    input wire [31:0]A,
    input wire [31:0]B,
    input wire [3:0]OP,
    output reg [31:0]C
);

always @(*) begin
    case (OP)
        4'b0000:begin
            C=A+B;
        end 
        4'b0001:begin
            C=A-B;
        end
        4'b0010:begin
            C=A&B;
        end
        4'b0011:begin
            C=A|B;
        end
        4'b0100:begin
            C=A << B[4:0];
        end
        4'b0101:begin
            C=A >> B[4:0] ;
        end
        4'b0110:begin
            C = A >>> B[4:0];
        end
        4'b0111:begin
            if (A[31]==B[31])begin
                if (A[30:0]<B[30:0])begin
                        C=1;
                end
                else begin
                    C=0;
                end
            end
            else if((A[31]==1) && (B[31]==0))begin
                C=1;
            end
            else if((A[31]==0) && (B[31]==1))begin
                C=0;
            end
        end
        4'b1000:begin
            if (A[31]==B[31])begin
                    if (A[30:0]>=B[30:0])begin
                        C=1;
                    end
                    else begin
                        C=0;
                    end
            end	
            else if((A[31]==1) & (B[31]==0))begin
                C=0;
            end
            else if((A[31]==0) & (B[31]==1))begin
                C=1;
            end
        end
        4'b1001:begin
            C= ( A<B) ;
        end
        4'b1010:begin
            C= (A>=B) ;
        end
        4'b1011:begin
            C= (A !=B) ;
        end
        4'b1100:begin
            C= (A==B);
        end
        4'b1101:begin
            C=A^B;
        end
        4'b1110:begin
            C=(A+B) & 32'hfffffffe;
        end
    endcase
end
endmodule 