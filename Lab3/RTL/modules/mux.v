module MUX #(
	parameter DWITH=32
)
(
	input  wire clk,
	input  wire rstn,
	input	wire	CON,//chip select negative??
	input	wire	[DWITH-1:0]		DI, //data in
	input	wire	[DWITH-1:0]		DI1,
	output	reg	[DWITH-1:0]		DOUT // data out
);

always @(posedge clk) begin
	if (~rstn) begin
		DOUT=32'b0;
	end
end

	always @ (*) begin
		if (CON)
			DOUT=DI;
		else
			DOUT=DI1;
	end

endmodule