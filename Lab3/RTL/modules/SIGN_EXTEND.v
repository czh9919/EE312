module SIGN_EXTEND#(
	parameter I_DWIDTH,
	parameter O_DWIDTH
)(
	input wire [I_DWIDTH-1:0]  I_DI,
	output wire [O_DWIDTH*2-1:0] O_DI
);

always @(*) begin  //clk or *
	o_Do[O_DWIDTH:0]<={I_DWIDTH{{i_DI[I_DWIDTH]}},i_DI[I_DWIDTH-1:0]};
end

endmodule // SIGN_EXTEND