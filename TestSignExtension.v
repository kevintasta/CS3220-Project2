`timescale 1ns / 1ps
module TestSignExtension ();
	wire[31:0] sext_out;
	reg[15:0] sext_in;
	
	SignExtension sext1(sext_in, sext_out);
	
	initial begin
		
		sext_in = 16'h0000;
	
		#10
		sext_in = 16'h0001;
		
		#10
		sext_in = 16'h7fff;
		
		#10
		sext_in = 16'h8000;
		
		#10
		$stop;
	end
endmodule