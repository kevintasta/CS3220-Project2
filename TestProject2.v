`timescale 1ns / 1ps
module TestProject2();

   parameter width = 32, aluop_width = 5, imm_width = 16;
	parameter DBITS = 32;
	reg[DBITS - 1: 0] instWord;
	reg[DBITS - 1: 0] pcOut;
	reg[DBITS - 1: 0] regfile_src1_out;
	reg[DBITS - 1: 0] regfile_src2_out;
	reg[DBITS - 1: 0] d_out;

	wire[DBITS - 1: 0] pcIn; // Implement the logic that generates pcIn; you may change pcIn to reg if necessary
	  
	// Define all wires here
	// PC Mux wires
	wire [DBITS - 1:0] pcmux_out;

	// PC increment adder wires
	wire[DBITS - 1:0] pcadder_out;
	wire[DBITS-1:0]pcadder_src1 = 32'd4;

	// Branch picker wires
	wire[DBITS - 1:0] brpick_out;

	// Branch adder wires
	wire[DBITS - 1:0] bradder_out;

	// Shifter wires
	wire[DBITS - 1:0] shift_out;

	// Register data in mux wires
	wire[DBITS - 1:0] regmux_out;

	// Sext wires
	wire[DBITS - 1:0] sext_out;

	// Alu mux wires
	wire[DBITS - 1:0] alumux_out;
	  
	// ALU wires
	wire[DBITS - 1:0] alu_out;
	wire alu_compare;

	// Put the code for getting opcode1, rd, rs, rt, imm, etc. here 
	  
	wire[3:0] src1_sel, src2_sel, wr_sel;
	wire[aluop_width - 1:0] alu_op;
	wire[1:0] pc_mux_sel, reg_data_in_mux, alu_src2_sel;
	wire reg_wr_en, data_wr_en;
	wire[imm_width - 1:0] imm;

	Controller control(instWord, imm, src1_sel, src2_sel, wr_sel, pc_mux_sel, reg_data_in_mux, alu_src2_sel, alu_op, reg_wr_en, data_wr_en);

	// Create all of the multiplexers
	Multiplexer alumux(regfile_src2_out, sext_out, shift_out, alu_src2_sel, alumux_out);
	Multiplexer regmux(alu_out, d_out, pcadder_out, reg_data_in_mux, regmux_out);
	Multiplexer pcmux(pcadder_out, brpick_out, alu_out, pc_mux_sel, pcIn);

	// Create all of the adders
	Adder pcadder(pcadder_src1, pcOut, pcadder_out);
	Adder bradder(shift_out, pcadder_out, bradder_out);

	// Create the branch picker
	BranchPicker brpick(pcadder_out, bradder_out, alu_compare, brpick_out);

	// Create the left shift_in
	LeftShift lshift(sext_out, shift_out);

	// Create the sign extender
	SignExtension sext(imm, sext_out);
	  
	// Create ALU unit
	ALU mainALU(regfile_src1_out, alumux_out, alu_op, alu_out, alu_compare);
  
	initial begin
		#10;
		//Test ADD --------------------------------------------
		
		//set pre conditions
		instWord = 32'b1100_0111_0001_0010_0011_000000000000;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000002;
	   regfile_src2_out = 32'h00000003;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("ADD D:R1, RS1:R2, RS2:R3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 3, Actual: %0H", src2_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 5, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test SUB --------------------------------------------
		
		//set pre conditions
		instWord = 32'b1100_0110_0001_0010_0011_000000000000;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000002;
	   regfile_src2_out = 32'h00000003;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("SUB D:R1, RS1:R2, RS2:R3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 3, Actual: %0H", src2_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: ffffffff, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test AND --------------------------------------------
		
		//set pre conditions
		instWord = 32'b1100_0000_0001_0010_0011_000000000000;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h0000000A;
	   regfile_src2_out = 32'h0000000D;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("AND D:R1, RS1:R2, RS2:R3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 3, Actual: %0H", src2_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 8, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test OR --------------------------------------------
		
		//set pre conditions
		instWord = 32'b1100_0001_0001_0010_0011_000000000000;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000003;
	   regfile_src2_out = 32'h00000006;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("OR D:R1, RS1:R2, RS2:R3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 3, Actual: %0H", src2_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 7, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test XOR --------------------------------------------
		
		//set pre conditions
		instWord = 32'b1100_0010_0001_0010_0011_000000000000;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000008;
	   regfile_src2_out = 32'h00000009;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("XOR D:R1, RS1:R2, RS2:R3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 3, Actual: %0H", src2_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 1, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test NAND --------------------------------------------
		
		//set pre conditions
		instWord = 32'b1100_1000_0001_0010_0011_000000000000;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h0000000D;
	   regfile_src2_out = 32'h00000007;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("NAND D:R1, RS1:R2, RS2:R3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 3, Actual: %0H", src2_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: fffffffa, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test NOR --------------------------------------------
		
		//set pre conditions
		instWord = 32'b1100_1001_0001_0010_0011_000000000000;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h0000000E;
	   regfile_src2_out = 32'h00000008;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("NOR D:R1, RS1:R2, RS2:R3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 3, Actual: %0H", src2_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: fffffff1, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test XNOR --------------------------------------------
		
		//set pre conditions
		instWord = 32'b1100_1010_0001_0010_0011_000000000000;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000004;
	   regfile_src2_out = 32'h00000003;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("XNOR D:R1, RS1:R2, RS2:R3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 3, Actual: %0H", src2_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: fffffff8, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test ADD-I --------------------------------------------
		
		//set pre conditions
		instWord = 32'b0100_0111_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000002;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("ADDI D:R1, RS1:R2, imm:3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 5, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test SUB-I --------------------------------------------
		
		//set pre conditions
		instWord = 32'b0100_0110_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000002;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("SUBI D:R1, RS1:R2, imm:3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: ffffffff, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test AND-I --------------------------------------------
		
		//set pre conditions
		instWord = 32'b0100_0000_0001_0010_0000000000001101;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h0000000A;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("ANDI D:R1, RS1:R2, imm:8 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 8, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test OR-I --------------------------------------------
		
		//set pre conditions
		instWord = 32'b0100_0001_0001_0010_0000000000000110;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000003;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("ORI D:R1, RS1:R2, imm:6 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 7, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test XOR-I --------------------------------------------
		
		//set pre conditions
		instWord = 32'b0100_0010_0001_0010_0000000000001001;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000008;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("XORI D:R1, RS1:R2, imm:9 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 1, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test NAND-I --------------------------------------------
		
		//set pre conditions
		instWord = 32'b0100_1000_0001_0010_0000000000000111;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h0000000d;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("NANDI D:R1, RS1:R2, imm:7 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: fffffffa, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test NOR-I --------------------------------------------
		
		//set pre conditions
		instWord = 32'b0100_1001_0001_0010_0000000000001000;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h0000000E;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("NORI D:R1, RS1:R2, imm:3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: fffffff1, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test XNOR-I --------------------------------------------
		
		//set pre conditions
		instWord = 32'b0100_1010_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000004;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("XNORI D:R1, RS1:R2, imm:3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: fffffff8, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test MVHI --------------------------------------------
		
		//set pre conditions
		instWord = 32'b0100_1111_0001_0000_0000000000000111;
	   pcOut = 32'h00000040;
		regfile_src1_out = 32'h00000004;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("MVHI D:R1, imm:7 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 70000, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test LW--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0111_0000_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000004;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("LW D:R1,imm:3(RS1:R2)------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 1234, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("mem_addr - Expect: 7, Actual: %0H", alu_out);
		$display("");
		
		#10;
		//Test SW--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0011_0000_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000004;
		regfile_src2_out = 32'h00000005;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("SW RS2:R1,imm:3(RS1:R2)------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 1, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 1, Actual: %b", data_wr_en);
		$display("mem_addr - Expect: 7, Actual: %0H", alu_out);
		$display("");
		
		#10;
		//Test BNE a = b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0101_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000004;
		regfile_src2_out = 32'h00000004;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BNE RS1:R1, RS2:R2 imm:3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test BNE a != b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0101_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000004;
		regfile_src2_out = 32'h00000005;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BNE RS1:R1, RS2:R2 imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test JAL--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0110_0000_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000004;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("JAL RD:R1, imm:3(RS1:R2)------------------");
		$display("pcIn - Expect: 10, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 2, Actual: %0H", src1_sel);
		$display("wr_sel - Expect: 1, Actual: %0H", wr_sel);
		$display("regmux_out - Expect: 44, Actual: %0H", regmux_out);
		$display("reg_wr_en - Expect: 1, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test BNEZ a < 0--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0001_0001_0000_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000004;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BNEZ RS1:R1, imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test BNEZ a = 0--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0001_0001_0000_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000000;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BNEZ RS1:R1, imm:3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test BNEZ a > 0--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0001_0001_0000_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h000000ff;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BNEZ RS1:R1, imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
		
		#10;
		//Test BT a < b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0000_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h0000000A;
		regfile_src2_out = 32'h0000000B;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BT RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BT a = b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0000_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h0000000A;
		regfile_src2_out = 32'h0000000A;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BT RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BT a > b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0000_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h0000000B;
		regfile_src2_out = 32'h0000000A;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BT RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BEQ a < b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0110_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000001;
		regfile_src2_out = 32'h00000002;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BEQ RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BEQ a = b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0110_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h000000ff;
		regfile_src2_out = 32'h000000ff;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BEQ RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BEQ a > b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_0110_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000003;
		regfile_src2_out = 32'h00000002;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BEQ RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BLTE a < b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_1100_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000002;
		regfile_src2_out = 32'h00000003;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BLTE RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BLTE a = b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_1100_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000002;
		regfile_src2_out = 32'h00000002;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BLTE RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BLTE a > b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_1100_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000003;
		regfile_src2_out = 32'h00000002;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BLTE RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BGTE a < b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_1010_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000002;
		regfile_src2_out = 32'h00000003;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BGTE RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 44, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BGTE a = b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_1010_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000002;
		regfile_src2_out = 32'h00000002;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BGTE RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");

		#10;
		//Test BGTE a > b--------------------------------------------
		
		//set pre conditions
		instWord = 32'b0010_1010_0001_0010_0000000000000011;
	   pcOut = 32'h00000040;
	   regfile_src1_out = 32'h00000003;
		regfile_src2_out = 32'h00000002;
	   d_out = 32'h00001234;
		
		#10;
		//check post conditions
		$display("BGTE RS1:R1, RS2:R2, imm:3 ------------------");
		$display("pcIn - Expect: 50, Actual: %0H", pcIn);
		$display("src1_sel - Expect: 1, Actual: %0H", src1_sel);
		$display("src2_sel - Expect: 2, Actual: %0H", src2_sel);
		$display("reg_wr_en - Expect: 0, Actual: %b", reg_wr_en);
		$display("data_wr_en - Expect: 0, Actual: %b", data_wr_en);
		$display("");
	
		
		
		#10;
		$stop;
	end
endmodule