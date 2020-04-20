module ADD 
(
	input	wire				CON,
	input	wire	[5:0]		DI, //data in
	input	wire	[5:0]		DI1,
	output	wire	[5:0]		DOUT // data out
);
	always @ (*) begin
			DOUT=DI1+DI;
	end

endmodule