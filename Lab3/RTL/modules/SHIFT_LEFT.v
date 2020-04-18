module SHIFT_LEFT(
	input wire [31:0] I_DI,
	input wire [31:0] O_DI
);

assign O_DI[31:0]={I_DI[29:0],{2'b0}};

endmodule // SHIFT_LEFT