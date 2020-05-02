module MUX3 #(
    parameter DWIDTH=32
)(
    input  wire clk,
    input  wire rstn,
    input  wire [1:0]CON,
    input  wire [DWIDTH-1:0] in0,
    input  wire [DWIDTH-1:0] in1,
    input  wire [DWIDTH-1:0] in2,
    output reg  [DWIDTH-1:0] DOUT
);

always @(posedge rstn) begin
	DOUT=32'b0;
end

always @(*) begin
    case (CON)
        2'b000:begin
            DOUT=in0;
        end
        2'b001:begin
            DOUT=in1;
        end
        2'b010:begin
            DOUT=in2;
        end
    endcase
end
endmodule //MUX3