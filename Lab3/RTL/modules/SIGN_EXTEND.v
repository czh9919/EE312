module SIGN_EXTEND(
	input wire [15:0]  I_DI,
	input wire clk,
	output wire [31:0] O_DI
);

always @(posedge clk ) begin  //clk or *
	o_Do[31:0]<={{16{i_DI[15]}},i_DI[15:0]};
end

endmodule // SIGN_EXTEND