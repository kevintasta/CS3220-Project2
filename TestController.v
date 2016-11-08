`timescale 1ns / 1ps
module TestController();
	parameter width = 32, aluop_width = 5, imm_width = 16;
	reg[width - 1:0]instr;
	wire[3:0] src1_sel, src2_sel, wr_sel;
	wire[aluop_width - 1:0] alu_op;
	wire[1:0] pc_mux_sel, reg_data_in_mux, alu_src2_sel;
	wire reg_wr_en, data_wr_en;
	wire[imm_width - 1:0] imm;

	Controller control(instr, imm, src1_sel, src2_sel, wr_sel, pc_mux_sel, reg_data_in_mux, alu_src2_sel, alu_op, reg_wr_en, data_wr_en);
	initial begin
		//JAL T0,JALTARG(FP)
		instr = 32'h604d00a0;
		#10;
		//ADDI T0,FP,-1
		instr = 32'h474dffff;
		#10;
		//ADDI T1,FP,2
		instr = 32'h475d0002;
		#10;
		//ADDI A0,FP,1
		instr = 32'h470d0001;
		#10;
		//ADD A1,T0,T1
		instr = 32'hc7145000;
		#10;
		//BEQ A0,A1,ADDWORKS
		instr = 32'h26010004;
		#10;
		
		//Patrick tests
		// ALU-R -----------------
		//ADD
		instr = 32'hc7210004;
		#10;
		
		//SUB
		instr = 32'hc6210004;
		#10;
		
		//AND
		instr = 32'hc0210004;
		#10;
		
		//OR
		instr = 32'hc1210004;
		#10;
		
		//XOR
		instr = 32'hc2210004;
		#10;
		
		//NAND
		instr = 32'hc8210004;
		#10;
		
		//NOR
		instr = 32'hc9210004;
		#10;
		
		//XNOR
		instr = 32'hca210004;
		#10;
		
		// ALU-I -----------------
		//ADDI
		instr = 32'h47210004;
		#10;
		
		//SUBI
		instr = 32'h46210004;
		#10;
		
		//ANDI
		instr = 32'h40210004;
		#10;
		
		//ORI
		instr = 32'h41210004;
		#10;
		
		//XORI
		instr = 32'h42210004;
		#10;
		
		//NANDI
		instr = 32'h48210004;
		#10;
		
		//NORI
		instr = 32'h49210004;
		#10;
		
		//XNORI
		instr = 32'h4a210004;
		#10;
		
		// Load/Store -----------------
		//LW
		instr = 32'h70210004;
		#10;
		//SW
		instr = 32'h30000445;
		#10;
		
		// CMP-R -----------------
		//F
		instr = 32'hd3210004;
		#10;
		
		//EQ
		instr = 32'hd6210004;
		#10;
		
		//LT
		instr = 32'hd9210004;
		#10;
		
		//LTE
		instr = 32'hdc210004;
		#10;
		
		//T
		instr = 32'hd0210004;
		#10;
		
		//NE
		instr = 32'hd5210004;
		#10;
		
		//GTE
		instr = 32'hdA210004;
		#10;
		
		//GT
		instr = 32'hdf210004;
		#10;
		
		// CMP-I -----------------
		//FI
		instr = 32'h53210004;
		#10;
		
		//EQI
		instr = 32'h56210004;
		#10;
		
		//LTI
		instr = 32'h59210004;
		#10;
		
		//LTEI
		instr = 32'h5c210004;
		#10;
		
		//TI
		instr = 32'h50210004;
		#10;
		
		//NEI
		instr = 32'h55210004;
		#10;
		
		//GTEI
		instr = 32'h5A210004;
		#10;
		
		//GTI
		instr = 32'h5f210004;
		#10;
		
		// Branch -----------------
		//BF
		instr = 32'h23210004;
		#10;
		
		//BEQ
		instr = 32'h26210004;
		#10;
		
		//BLT
		instr = 32'h29210004;
		#10;
		
		//BLTE
		instr = 32'h2c210004;
		#10;
		
		//BEQZ
		instr = 32'h22210004;
		#10;
		
		//BLTZ
		instr = 32'h2d210004;
		#10;
		
		//BLTEZ
		instr = 32'h28210004;
		#10;
		
		//BT
		instr = 32'h20210004;
		#10;
		
		//BNE
		instr = 32'h25210004;
		#10;
		
		//BGTE
		instr = 32'h2a210004;
		#10;
		
		//BGT
		instr = 32'h2b210004;
		#10;
		
		//BNEZ
		instr = 32'h21210004;
		#10;
		
		//BGTEZ
		instr = 32'h2e210004;
		#10;
		
		//BGTZ
		instr = 32'h2f210004;
		#10;
		
		//JAL
		instr = 32'h60210004;
		#10;
		
		
		
		
		
		$stop;
	end
endmodule