module ADD 
(
	input	wire	[9:0]       CON,//chip select negative??
	input	wire	[5:0]		DI1, //data in
    input   wire    [5:0]       DI,
	output	wire	[5:0]		DOUT // data out
);
	always @ (*) begin
		// Asynchronous read
		if (CON)
			DOUT=DI1+DI;
	end

endmodule