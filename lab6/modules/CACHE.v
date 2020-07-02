`define LEN 8
`define FR_LEN 2
`define MID_LEN 6
`define BA_LEN 1
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

reg p[0:LEN-1];
reg [FR_LEN:0]index[0:LEN-1];
reg [MID_LEN:0]sign[0:LEN-1];

reg [31:0]cache0[0:LEN-1];
reg [31:0]cache1[0:LEN-1];
reg [31:0]cache2[0:LEN-1];
reg [31:0]cache3[0:LEN-1];

reg [2:0]state;
wire MWEN;
reg valid;

always @(posedge rstn) begin //todo这里补下
	stall=0;
	DOUT=32'b00;
	state=0;
end

assign valid=p[ADDR[11:9]]&(sign[ADDR[11:9]]==ADDR[8:2]);
D_MEM(
	.clk(clk),
	.rstn(rstn),
	.ADDR(ADDR),
	.WEN(MEMW)//todo
	.DI(DI),
	.DOUT(),//todo 二选一
	//todo 少参数
)

always @(posedge clk) begin //? 没想好有没有必要
	/* if(~CSN)
	begin
		if (WEN) begin
			state=3'b000;
			//todo 取
		end
	end */
	state=3'b0;
	state[1]=~WEN;
/* 	if (~CSN) begin
		if (~WEN) begin
			state=3'b010;
		end
	end */
end

MUX4(
	.clk(clk),
	.rstn(rstn),
	.CON(ADDR[BA_LEN]),
	.in0(cache0),
	.in1(cache1),
	.in2(cache2),
	.in3(cache3),
	.DOUT(DOUT)
);
assign state[0]=valid;
always @(*) begin
	if (state[1]==1) begin
		MEMW=0;
		//save
	end
	if (state==3'b01) begin
		stall=0;
	end
	if (state==3'b00) begin
		stall=1;
		MEMW=1;
	end
end
//todo主要代码
/* always @(*) begin
	if (state[1]==1) begin
		if (stall==0) begin
			// 进cache
		end
		// 直接进mem
		//todo 存
	end
	if (state[1]==0) begin
		//todo 取
	end
end */
/* reg [31:0] data[0:LEN-1];//32*4 byte
reg [FR_LEN:0] maps[0:LEN-1];//索引
reg [MID_LEN:0] sign0[0:LEN-1];
reg [BA_LEN:0] sign1[0:LEN-1];//标记_2
reg [FR_LEN]p[0:LEN-1];//有效位
wire MWEN;
reg [2:0]state;
always @(posedge rstn) begin //todo这里补下
	stall=0;
	DOUT=32'b00;
	state=0;
end

reg valid;
assign valid=p[ADD[11:9];
assign stall=~(valid[ADDR[BA_LEN:0]]&(ADDR[BA_LEN:0]==sign1[ADDR[BA_LEN:0]])&(ADDR[8:3]==sign0[MID_LEN:0]));
 */


//可以分成两个model，一个写一个读， 一个也行，注意区分加注释
//也可以一个model分两块写，记得加注释
endmodule //CACHE