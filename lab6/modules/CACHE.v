module CACHE (
    input wire clk,
	input wire rstn,
	input wire CSN,
	input wire [11:0]	ADDR, //地址
	input wire [31:0]	DI, //进入的数据
	//todo input 还有线 连着自己写的mem model
	output	reg	[31:0]	DOUT, //出去的数据
	output  reg stall //没找到就是1，通常为0
);
reg [31:0] data[0:31];
//todo 漏了东西 索引 有效位 标记

always @(posedge rstn) begin //todo这里补下
	stall=0;

end

//todo主要代码

//可以分成两个model，一个写一个读， 一个也行，注意区分加注释
//也可以一个model分两块写，记得加注释
endmodule //CACHE