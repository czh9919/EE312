module SIGN_EXTEND#(
	parameter I_DWIDTH=12,
	parameter O_DWIDTH=32
)(
	input wire [I_DWIDTH-1:0]  I_DI,
	output reg [O_DWIDTH-1:0] O_DI
);

always @(*) begin  //clk or *
	O_DI[O_DWIDTH:0]<={{(O_DWIDTH-I_DWIDTH){I_DI[I_DWIDTH]}},I_DI[I_DWIDTH-1:0]};
end

endmodule // SIGN_EXTEND