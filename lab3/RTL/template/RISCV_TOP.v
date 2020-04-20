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
	output wire HALT,                   // if set, terminate program
	output reg [31:0] NUM_INST,         // number of instruction completed
	output wire [31:0] OUTPUT_PORT      // equal RF_WD this port is used for test
	);

	assign OUTPUT_PORT = RF_WD;

	initial begin
		NUM_INST <= 0;
	end

	// Only allow for NUM_INST
	always @ (negedge CLK) begin
		if (RSTn) NUM_INST <= NUM_INST + 1;
	end

	// TODO: implement
	// TODO: control
	assign RF_RA1 = I_MEM_DI[19:15];
	assign RF_RA2 = I_MEM_DI[24:20];
	assign RF_WA1=I_MEM_DI[11:7];
	// TODO:WR

	wire [12:0]PC_4_to_MUX;
	wire [12:0]Back_to_PC;
	wire [12:0]OUT_PC;
	PC PC_TOP(
		.clk(CLK),
		.rstn(RSTn),
		.I_MEM_ADDR(Back_to_PC),
		.O_MEM_ADDR(OUT_PC)
	);
	assign I_MEM_ADDR=OUT_PC;
	//TODO backTOPC connect with outPC
	wire [24:0]SIGN_EXTEND_to_MUX_ADD;
	wire [32:0]MUX_TO_ALU;
	MUX #(
		DWITH(12)
	) BeforeALU(
		.CON(ALUSrc),
		.DI(RF_RA2),
		.DI1(SIGN_EXTEND_to_MUX_ADD),
		.DOUT(MUX_TO_ALU)//!ALU out
	);
	wire [32:0]ALU_Ans;
	ALU(
		.A(RF_RA1),
		.B(MUX_TO_ALU),
		.OP(ALUSrc),
		.C(ALU_Ans)
	);

	SIGN_EXTEND #(
		I_DWIDTH(12),
		O_DWIDTH(24)
	) Down_REG(
		.I_DI(I_MEM_DI[31:20]),
		.O_DI(SIGN_EXTEND_to_MUX_ADD)
	);
	assign D_MEM_ADDR=ALU_Ans;
	assign D_MEM_DOUT=RF_RA2;
	wire MUX_to_MUX;
	MUX #(
		DWITH(32)//! may not 32
	)MUX_Down_MEM(
		.CON(MemtoReg),
		.DI(ALU_Ans),
		.DI1(D_MEM_DI),
		.DOUT(MUX_to_MUX)
	);
	MUX #(
		DWITH(32)
	) MUX_Left_WD(
		.CON(isJAL),//!warning  may change name
		.DI(MUX_to_MUX),
		.DI1(PC_4_to_MUX),
		.DOUT(RF_WD)
	);

	// TODO: to end
endmodule //
