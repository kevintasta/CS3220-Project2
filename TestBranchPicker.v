`timescale 1ns / 1ps
module TestBranchPicker ();
	wire[31:0] mux_out;
	reg[31:0] src0;
	reg[31:0] src1;
	reg[0:0] sel;
	
	BranchPicker brmux1(src0, src1, sel, mux_out);
	
	initial begin
		
		src0 = 32'h00000000;
		src1 = 32'h00000001;
		sel = 1'b0;
	
		#10
		sel = 1'b1;
		
		#10
		$stop;
	end
endmodule