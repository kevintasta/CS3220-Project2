`timescale 1ns / 1ps
module TestProject2();
	reg  [9:0] SW;
	reg  [3:0] KEY;
	reg  CLOCK_50;
	wire [9:0] LEDR;
	wire [6:0] HEX0,HEX1,HEX2,HEX3;
	wire [31:0] instWord;
	Project2 test(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,CLOCK_50, instWord);
	initial begin
		KEY = 4'd0;
		SW = 10'd0;
		//pc_reset = 1'b1;
		CLOCK_50 = 1'b0;
		#10;
		CLOCK_50 = 1'b1;
		#10;
		//pc_reset = 1'b0;
		CLOCK_50 = 1'b0;
		#10;
		CLOCK_50 = 1'b1;
		#10;
		CLOCK_50 = 1'b0;
		#10;
		CLOCK_50 = 1'b0;
		#10;
		CLOCK_50 = 1'b0;
		#10;
		CLOCK_50 = 1'b0;
		#10;
		CLOCK_50 = 1'b0;
		#10;
		CLOCK_50 = 1'b0;
		#10;
		$stop;
	end
endmodule