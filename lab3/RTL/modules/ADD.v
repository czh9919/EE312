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

always @(posedge clk) begin
	if (~rstn) begin
		DOUT=32'b0;
	end
end
always @ (*) begin
	DOUT[DWIDTH-1:0]=DI1[DWIDTH-1:0]+DI[DWIDTH-1:0];
	$display("%b has been passed",DI1);
	$display("%b has been passed",DI);
	$display("%b has been passed",DOUT);
end

endmodule