module ADD 
(
	input	wire				CON,
	input	wire	[5:0]		DI1, //data in
	input	wire	[5:0]		DI,
	output	wire	[5:0]		DOUT // data out
);
	always @ (*) begin
		if (CON)
			DOUT=DI1+DI;
	end

endmodule