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
	wire isnot_PC_4;
	wire back_PC_CON;
	wire isJALR;
	wire isCout;
	wire isLUI;
	wire isLUIAUI;
	wire isJAL;
	wire is_down_s;
	wire [4:0]ALUOp;
	wire chos_LUI_JALR;

	CONTROL CONT(
		.I_OP(I_MEM_DI),
		.O_MemtoReg(MemtoReg),
		.O_ALUSrc(ALUSrc),
		.O_RegWrite(RF_WE),
		.O_MemWrite(D_MEM_WEN),
		.O_MemRead(D_MEM_BE[0]),
		.O_ALPOp(ALUOp),
		.isnot_PC_4(isnot_PC_4),
		.isJALR(isJALR),
		.isCout(isCout),
		.isJAL(isJAL),
		.is_down_se(is_down_se),
		.isLUI(isLUI),
		.isLUIAUI(isLUIAUI)
	);
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
		.I_MEM_ADD(Back_to_PC),
		.O_MEM_ADD(OUT_PC)
	);
	always @(*) begin
		I_MEM_ADDR=OUT_PC;
	end
	//TODO backTOPC connect with outPC
	wire [24:0]SIGN_EXTEND_to_MUX_ADD;
	wire [32:0]MUX_TO_ALU;
	MUX #(
		.DWITH(12)
	) BeforeALU(
		.CON(ALUSrc),
		.DI(RF_RA2),
		.DI1(SIGN_EXTEND_to_MUX_ADD),
		.DOUT(MUX_TO_ALU)//!ALU out
	);
	wire [32:0]ALU_Ans;
	ALU alu(
		.A(RF_RA1),
		.B(MUX_TO_ALU),
		.OP(ALUOp),
		.C(ALU_Ans)
	);

	SIGN_EXTEND #(
		.I_DWIDTH(12),
		.O_DWIDTH(24)
	) Down_REG(
		.I_DI(I_MEM_DI[31:20]),
		.O_DI(SIGN_EXTEND_to_ready_MUX_ADD_0)
	);
	SIGN_EXTEND#(
		.I_DWIDTH(20),
		.O_DWIDTH(40)
	)Down_Down_REG(
		.I_DI(I_MEM_DI[31:12]),
		.O_DI(SIGN_EXTEND_to_ready_MUX_ADD_1)
	);
	MUX #(
		.DWITH(12)
	)After_Down_REG(
		.CON(is_down_se),
		.DI(SIGN_EXTEND_to_ready_MUX_ADD_1),
		.DI1(SIGN_EXTEND_to_ready_MUX_ADD_0),
		.DOUT(SIGN_EXTEND_to_MUX_ADD)
	);
	assign D_MEM_ADDR=ALU_Ans;
	assign D_MEM_DOUT=RF_RA2;
	wire MUX_to_MUX;
	MUX #(
		.DWITH(32)//! may not 32
	)MUX_Down_MEM(
		.CON(MemtoReg),
		.DI(ALU_Ans),
		.DI1(chos_LUI_JALR),
		.DOUT(MUX_to_MUX)
	);
	MUX #(
		.DWITH(32)
	) MUX_Left_WD(
		.CON(isJAL),//!warning  may change name
		.DI(PC_4_to_MUX),
		.DI1(MUX_to_MUX),
		.DOUT(RF_WD)
	);

	wire Out_ADD;
	ADD #(
		.DWIDTH(14)
	) Up_reg_right(
		.DI(OUT_PC),
		.DI1(SIGN_EXTEND_to_MUX_ADD),
		.DOUT(Out_ADD)
	);

	wire out_and;
	wire out_mux_to_mux;
	MUX#(
		.DWITH(32)
	) Behind_ADD(
		.CON(isJALR),
		.DI(out_and),
		.DI1(Out_ADD),
		.Dout(out_mux_to_mux)
	);
	wire backPC1;
	MUX#(
		.DWITH(32)
	)MUXtoMUX(
		.CON(isnot_PC_4),
		.DI(out_mux_to_mux),
		.DI1(PC_4_to_MUX),
		.DOUT(backPC1)
	);

	wire out_add_2;
	MUX #(
		.DWITH(32)
	) Jumpcheck(
		.CON(isnot_PC_4),
		.DI(out_add_2),
		.DI1(backPC1),
		.DOUT(Back_to_PC)
	);

	wire SIGN_EXTEND_to_ADD;
	SIGN_EXTEND#(
		.I_DWIDTH(7),
		.O_DWIDTH(14)
	)SIGN_EXTEND_to_add(
		.I_DI(I_MEM_DI[31:25]),
		.O_DI(SIGN_EXTEND_to_ADD)
	);
	ADD#(
		.DWIDTH(12)
	) ADD_2(
		.DI(SIGN_EXTEND_to_ADD),
		.DI1(OUT_PC),
		.DOUT(out_add_2)
	);
	MUX #(
		.DWITH(14)
	)MUX_behind_PC(
		.CON(back_PC_CON),
		.DI(backPC1),
		.DI1(out_add_2)
	);
	
	MUX #(
		.DWITH(1)
	) Afer_ALU(
		.CON(isCout),
		.DI(Cout),
		.DI1(0),
		.DOUT(back_PC_CON)
	);
	wire for_LUI_AUIPC_i;
	wire for_LUI_AUIPC_o;
	wire imm_12;
	assign imm_12=I_MEM_DI[31:12]<<12;
	ADD#(
		.DWIDTH(12)
	) forLUI_AUI(
		.DI(imm_12),
		.DI1(OUT_PC),
		.DOUT(for_LUI_AUIPC_i)
	);

	MUX #(
		.DWITH(32)
	) isLUIMUX(
		.CON(isLUI),
		.DI(imm_12),
		.DI1(for_LUI_AUIPC_i),
		.DOUT(for_LUI_AUIPC_o)
	);
	MUX #(
		.DWITH(32)
	) MUX_right_MEM(
		.CON(isLUIAUI),
		.DI(for_LUI_AUIPC_o),
		.DI1(D_MEM_DI),//! wrong
		.DOUT(chos_LUI_JALR)
	);

	// TODO: to end
endmodule //
