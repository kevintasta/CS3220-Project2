module LeftShift(in, out);
	parameter width = 32;
	input[width-1:0]in;
	output[width-1:0]out;
	assign out = in << 2;
endmodule