module SIGN_EXTEND#(
	parameter I_DWIDTH=12,
	parameter O_DWIDTH=32
)(
	input  wire clk,
	input  wire rstn,
	input wire [I_DWIDTH-1:0]  I_DI,
	output reg [O_DWIDTH-1:0] O_DI
);

always @(posedge clk) begin
	if (~rstn) begin
		O_DI=32'b0;
	end
end

always @(*) begin  //clk or *
	O_DI[O_DWIDTH:0]<={{(O_DWIDTH-I_DWIDTH){I_DI[I_DWIDTH]}},I_DI};
end

endmodule // SIGN_EXTEND