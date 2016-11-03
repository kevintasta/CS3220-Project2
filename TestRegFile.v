`timescale 1ns / 1ps
module TestRegFile();
	parameter index = 4, width = 32, regnumer = (1 << index);
	reg wr_en, clk;
	reg[3:0] src1_sel, src2_sel, wr_sel;
	reg[width - 1:0] data_in; 
	wire[width - 1:0] src1_out, src2_out;
	RegFile file(src1_sel, src2_sel, wr_sel, data_in, wr_en, clk, src1_out, src2_out);
	initial begin
		//BT T0,T0,ADDFAILED
		src1_sel = 4'b0100;
		src2_sel = 4'b0101;
		wr_sel = 4'b0110;
		data_in = 32'd55;
		wr_en = 1'b0;
		clk = 1'b0;
		#10;
		//XOR A0,A0,A1
		wr_en = 1'b1;
		clk = 1'b1;
		#10;
		clk = 1'b0;
		#10;
		//BNE T0,T1,INIT
		clk = 1'b1;
		#10;
		//SW A3,0(T0)
		clk = 1'b0;
		src1_sel = 4'b0110;
		#10;
		//LW A3,0(T1)
		clk = 1'b1;
		#10;
		$stop;
	end
endmodule