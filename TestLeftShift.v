`timescale 1ns / 1ps
module TestLeftShift ();
	wire[31:0] out;
	reg[31:0] in;
	
	LeftShift ls1(in, out);
	
	initial begin
		
		in = 32'h00000000;
		
		#10
		in = 32'h00000001;
		
		#10
		in = 32'h0000ffff;
		
		#10
		in = 32'h3fffffff;
		
		#10
		in = 32'hffffffff;
		
		#10
		$stop;
	end
endmodule