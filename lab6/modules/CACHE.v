`define LEN 32
`define FR_LEN 4
`define BA_LEN 6
module CACHE (
    input wire clk,
	input wire rstn,
	input wire CSN,
	input  wire WEN,
	input wire [11:0]	ADDR, //地址
	input wire [31:0]	DI, //进入的数据
	//todo input 还有线 连着自己写的mem model
	output	reg	[31:0]	DOUT, //出去的数据
	output  reg stall, //没找到就是1，通常为0
);
reg [31:0] data[0:LEN-1];//32*4 byte
reg [FR_LEN:0] maps[0:LEN-1];//索引
reg [BA_LEN:0] sign[0:LEN-1];//标记
reg p[0:LEN-1];//有效位
wire MWEN;
always @(posedge rstn) begin //todo这里补下
	stall=0;
	DOUT=32'b00;
end

assign stall=~(p[ADD[11:8]]&(ADDR[BA_LEN:0]==sign[BA_LEN:0]));

D_MEM(
	.clk(clk),
	.rstn(rstn),
	.ADDR(ADDR),
	.WEN(MEMW)//todo
	.DI(DI),
	.DOUT(),//todo 二选一
	//todo 少参数
)

always @(posedge clk) begin
	stall=0;
	if(~CSN)
	begin
		if (WEN) begin
			DOUT=data[ADDR[11:8]];
			//todo 取
		end
	end
end
//todo主要代码
always @(*) begin

end

//可以分成两个model，一个写一个读， 一个也行，注意区分加注释
//也可以一个model分两块写，记得加注释
endmodule //CACHE