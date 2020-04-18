module MUX 
(
	input	wire	            CON,//select 
	input	wire	[5:0]		DI1, //data in
    input   wire    [5:0]       DI,
	output	wire	[5:0]		DOUT // data out
);
	always @ (*) begin
		if (CON)
			DOUT=DI;
        else
            DOUT=DI1;
	end

endmodule