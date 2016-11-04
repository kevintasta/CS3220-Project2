`timescale 1ns / 1ps
module TestAdder ();
	wire[31:0] sum;
	reg[31:0] src1;
	reg[31:0] src2;
	
	Adder adder1(src1, src2, sum);
	
	initial begin
		
		// 0 + 0 = 0
		src1 = 32'h00000000;
		src2 = 32'h00000000;
		
		#10
		// 1 + 2 = 3
		src1 = 32'h00000001;
		src2 = 32'h00000002;
		
		#10
		// 1 + (-1) = 0
		src1 = 32'h00000001;
		src2 = 32'hffffffff;
		
		#10
		// 1 + (-2) = -1 ffffffff
		src1 = 32'h00000001;
		src2 = 32'hfffffffe;
		
		#10
		// (-1) + (-2) = -3 fffffffd
		src1 = 32'hffffffff;
		src2 = 32'hfffffffe;
		
		#10
		$stop;
		
	end
endmodule