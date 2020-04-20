module MUX #(
	parameter DWITH
)
(
	input	wire	CON,//chip select negative??
	input	wire	[DWITH-1:0]		DI, //data in
	input	wire	[DWITH-1:0]		DI1,
	output	wire	[DWITH-1:0]		DOUT // data out
);
	always @ (*) begin
		if (CON)
			DOUT=DI;
		else
			DOUT=DI1;
	end

endmodule