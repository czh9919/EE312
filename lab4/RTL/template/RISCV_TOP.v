module RISCV_TOP (
	//General Signals
	input wire CLK,
	input wire RSTn,

	//I-Memory Signals
	output wire I_MEM_CSN,
	input wire [31:0] I_MEM_DI,//input from IM
	output reg [11:0] I_MEM_ADDR,//in byte address

	//D-Memory Signals
	output wire D_MEM_CSN,
	input wire [31:0] D_MEM_DI,
	output wire [31:0] D_MEM_DOUT,
	output wire [11:0] D_MEM_ADDR,//in word address
	output wire D_MEM_WEN,
	output wire [3:0] D_MEM_BE,

	//RegFile Signals
	output wire RF_WE,
	output wire [4:0] RF_RA1,
	output wire [4:0] RF_RA2,
	output wire [4:0] RF_WA1,
	input wire [31:0] RF_RD1,
	input wire [31:0] RF_RD2,
	output wire [31:0] RF_WD,
	output wire HALT,
	output reg [31:0] NUM_INST,
	output wire [31:0] OUTPUT_PORT
	);

	// TODO: implement multi-cycle CPU

	//control
	wire CON_A;
	wire [1:0]CON_B;
	wire PVSwrite;//pc
	wire [1:0]CON_sign;
	wire PCsource;
	wire RegDst;
	wire [3:0] ALUop;

	wire[31:0] num_inst;
	CONTROL control(
		.clk(CLK),
		.rstn(RSTn),
		.I(I_MEM_DI),
		.PC_source(PCsource),
		.MUX_A(CON_A),
		.MUX_B(CON_B),
		.RegWrite(RF_WE),
		.MemWrite(D_MEM_WEN),
		.ALUOp(ALUop),
		.sign_ex(CON_sign),
		.Reg_MUX(RegDst),
		.I_MEM_write(PVSwrite),
		.NUM_INS(num_inst)
	);
	always @(*) begin
		NUM_INST=(num_inst)>>2;
	end
	

	assign OUTPUT_PORT=RF_WD;
	
	//control
	wire [11:0] back_PC;
	wire [11:0] out_PC;
	wire [31:0] out_ALUout;
	wire [31:0] out_ins_REG;
	wire [31:0] back_WD;
	wire [31:0] out_A;
	wire [31:0] out_B;
	wire [31:0] ALU_A;
	wire [31:0] ALU_B;
	wire [31:0]MUX_B_2;
	wire [11:0] W_BS_Sign0;
	wire [11:0] W_BS_Sign1;
	wire [31:0] W_BS_Sign2;
	wire [31:0] SM0;
	wire [31:0] SM1;
	wire [31:0] SM2;
	wire [31:0] ALU_ans;
	wire [31:0] out_data_reg;

	HALT halt(
		.I_MEM(I_MEM_DI),
		.RF_RD(RF_RD1),
		.HALT_o(HALT)
	);

	PC PC_TOP(
		.clk(CLK),
		.rstn(RSTn),
		.PCwrite(PVSwrite),
		.I_MEM_ADD(back_PC),
		.O_MEM_ADD(out_PC),
		.I_MEM_CSN(I_MEM_CSN),
		.D_MEM_CSN(D_MEM_CSN)
	);

	always @(*) begin
		I_MEM_ADDR=out_PC;
	end

	REG#(
		.DWIDTH(32)
	) ins_REG(
		.clk(CLK),
		.rstn(RSTn),
		.in(I_MEM_DI),
		.DOUT(out_ins_REG)
	);
	REG #(
		.DWIDTH(32)
	) data_REG(
		.clk(CLK),
		.rstn(RSTn),
		.in(D_MEM_DI),
		.DOUT(out_data_reg)
	);

	assign D_MEM_ADDR=ALU_ans;
	assign RF_RA1=out_ins_REG[19:15];
	assign RF_RA2=out_ins_REG[24:20];

	assign RF_WA1=out_ins_REG[11:7];
	assign RF_WD=back_WD;
	assign D_MEM_DOUT=out_B;
	
	MUX#(
		.DWIDTH(32)
	)before_WD(
		.clk(CLK),
		.rstn(RSTn),
		.CON(RegDst),
		.in0(out_ALUout),
		.in1(out_data_reg),
		.DOUT(back_WD)
	);
	REG #(
		.DWIDTH(12)
	)BS0(
		.clk(CLK),
		.rstn(RSTn),
		.in(out_ins_REG[31:20]),
		.DOUT(W_BS_Sign0)
	);

	REG #(
		.DWIDTH(12)
	)BS1(
		.clk(CLK),
		.rstn(RSTn),
		.in({{out_ins_REG[31:25]},{out_ins_REG[11:7]}}),
		.DOUT(W_BS_Sign1)
	);
	
	REG #(
		.DWIDTH(32)
	)BS2(
		.clk(CLK),
		.rstn(RSTn),
		.in({27'b0,out_ins_REG[24:20]}),
		.DOUT(W_BS_Sign2)
	);
	SIGN_EXTEND #(
		.I_DWIDTH(12),
		.O_DWIDTH(32)
	) sign0(
		.clk(CLK),
		.rstn(RSTn),
		.I_DI(W_BS_Sign0),
		.O_DI(SM0)
	);
	SIGN_EXTEND #(
		.I_DWIDTH(12),
		.O_DWIDTH(32)
	) sign1(
		.clk(CLK),
		.rstn(RSTn),
		.I_DI(W_BS_Sign1),
		.O_DI(SM1)
	);
	assign SM2=W_BS_Sign2;
	//EX
	REG#(
		.DWIDTH(32)
	)A(
		.clk(CLK),
		.rstn(RSTn),
		.in(RF_RD1),
		.DOUT(out_A)
	);

	REG#(
		.DWIDTH(32)
	)B(
		.clk(CLK),
		.rstn(RSTn),
		.in(RF_RD2),
		.DOUT(out_B)
	);

	MUX #(
		.DWIDTH(32)
	) before_A_ALU(
		.clk(CLK),
		.rstn(RSTn),
		.CON(CON_A),
		.in0({20'b0,out_PC}),
		.in1(out_A),
		.DOUT(ALU_A)
	);

	MUX3 #(
		.DWIDTH(32)
	) before_B_ALU(
		.clk(CLK),
		.rstn(RSTn),
		.CON(CON_B),
		.in0(out_B),
		.in1(MUX_B_2),
		.in2(32'b100),
		.DOUT(ALU_B)
	);

	MUX3 #(
		.DWIDTH(32)
	) Aft_Sign(
		.clk(CLK),
		.rstn(RSTn),
		.CON(CON_sign),
		.in0(SM0),
		.in1(SM1),
		.in2(SM2),
		.DOUT(MUX_B_2)
	);

	ALU ALU_top(
		.A(ALU_A),
		.B(ALU_B),
		.OP(ALUop),
		.C(ALU_ans)
	);

	REG #(
		.DWIDTH(32)
	) ALUOUT(
		.clk(CLK),
		.rstn(RSTn),
		.in(ALU_ans),
		.DOUT(out_ALUout)
	);
	MUX #(
		.DWIDTH(12)
	) aft_ALU(
		.clk(CLK),
		.rstn(RSTn),
		.CON(PCsource),
		.in0(ALU_ans[11:0]),
		.in1(out_ALUout[11:0]),
		.DOUT(back_PC)
	);
endmodule //
