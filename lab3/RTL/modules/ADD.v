module ADD 
(  
	input	wire	[5:0]		DI1, 
    input   wire    [5:0]       DI,
	output	wire	[5:0]		DOUT 
);
	always @ (*) begin
			DOUT=DI1+DI;
	end

endmodule