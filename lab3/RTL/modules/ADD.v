module ADD #(
	parameter DWIDTH=32
)
(
	input  wire clk,
	input  wire rstn,
	input	wire	[DWIDTH-1:0]		DI, //data in
	input	wire	[DWIDTH-1:0]		DI1,
	output	reg		[DWIDTH-1:0]		DOUT // data out
);

always @(posedge clk or negedge rstn) begin
		DOUT=32'b0;
end
always @ (*) begin
	DOUT[DWIDTH-1:0]=DI1[DWIDTH-1:0]+DI[DWIDTH-1:0];
end

endmodule