module sampler (
	input pclk,
	input presetn,
	input [31:0] data_i,
	output psel,
	output penable,
	output [7:0] paddr,
	output [31:0] pwdata,
	output pwrite,
	input pready,
	input [31:0] prdata
	
);

wire out_counter;

counter counter(
	.pclk(pclk),
	.presetn(presetn),
	.value(out_counter)
);

fsm fsm(
	.clk2(out_counter),
	.pclk(pclk),
	.presetn(presetn),
	.paddr(paddr),
	.data_i(data_i),
	.pready(pready),
	.psel(psel),
	.penable(penable), 
	.pwdata(pwdata),
	.pwrite(pwrite)
	
);




endmodule
