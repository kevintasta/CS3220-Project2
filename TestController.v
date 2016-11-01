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
		//ADDI S1,S1,13
		instr = 32'h4777000d;
		#10;
		//BNE T0,T1,INIT
		instr = 32'h2545fffc;
		#10;
		$stop;
	end
endmodule