`timescale 1ns / 1ps
module TestMultiplexer ();
	wire[31:0] mux_out;
	reg[31:0] src0;
	reg[31:0] src1;
	reg[31:0] src2;
	reg[1:0] sel;
	
	Multiplexer mux1(src0, src1, src2, sel, mux_out);
	
	initial begin
		
		src0 = 32'h00000000;
		src1 = 32'h00000001;
		src2 = 32'h00000002;
		sel = 2'b00;
	
		#10
		sel = 2'b01;
		
		#10
		sel = 2'b10;
		
		#10
		sel = 2'b11;
		
		#10
		$stop;
	end
endmodule