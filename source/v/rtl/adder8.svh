module adder8(
	output c,
	input [7:0] a,
	input [7:0] b,
	output [7:0] sum
);

assign {c,sum} = a + b;

endmodule
