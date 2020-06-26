module REG #(
    parameter DWIDTH=32
)(
    input  wire clk,
    input  wire rstn,
    input  wire [DWIDTH-1:0] in,
    output reg [DWIDTH-1:0] DOUT

);

always @(posedge rstn) begin
	DOUT[DWIDTH-1:0]=32'b0;
end

always @(posedge clk) begin
    DOUT[DWIDTH-1:0]=in;
end

endmodule //Ins_REG