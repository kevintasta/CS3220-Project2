`timescale 1ns / 1ps
module TestRegister ();
	wire[31:0] data_out;
	reg clk;
	reg reset;
	reg wrt_en;
	reg[31:0] data_in;
	
	Register reg1(clk, reset, wrt_en, data_in, data_out);
	
	initial begin
		data_in = 8'b11111111;
		wrt_en = 1'b0;
		reset = 1'b0;
		
		#10
		data_in = 8'b10011010;
		wrt_en = 1'b0;
		
		#10
		data_in = 8'b11111111;
		wrt_en = 1'b1;
		
		#10
		data_in = 8'b10011010;
		wrt_en = 1'b0;
		
		#10
		data_in = 8'b10011010;
		wrt_en = 1'b1;
		
		#10
		reset = 1'b1;
		
		#10
		$stop;
	end
	
	always begin
		#5 clk = ~clk;
	end
endmodule