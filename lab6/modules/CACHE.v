module CACHE (
    input	wire			CLK,
	input	wire			CSN,
	input	wire	[11:0]	ADDR,
	input	wire	[31:0]	DI, 
	output	wire	[31:0]	DOUT 
);
reg		[31:0]		da[0 : 31];//二维数组？？

endmodule //CACHE