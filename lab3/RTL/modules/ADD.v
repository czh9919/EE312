module ADD #(
	parameter DWIDTH
)
(
	input	wire	[DWIDTH-1:0]		DI, //data in
	input	wire	[DWIDTH-1:0]		DI1,
	output	reg	[DWIDTH-1:0]		DOUT // data out
);
	always @ (*) begin
		DOUT[DWIDTH:0]=DI1[DWIDTH:0]+DI[DWIDTH:0];
	end

endmodule