module top2( 
	input pclk,
	input compute_req,
	input presetn,
	input [31:0] data_i,
	//input pready, 
	output [31:0] datao,
	output valido

);

wire psel_sampler;
wire psel_computer;
wire penable_computer;
wire penable_sampler;
wire pwrite_computer;
wire pwrite_sampler;
wire [7:0] paddr_sampler;
wire [7:0] paddr_computer;
wire [31:0] pwdata_sampler;
wire [31:0] pwdata_computer;
wire [31:0] prdata;


wire psel_mem;
wire penable_mem;
wire [7:0] paddr_mem;
wire [31:0] pwdata_mem;
wire pwrite_mem;

assign psel_mem = psel_sampler | psel_computer;
assign penable_mem = penable_sampler | penable_computer;
assign paddr_mem = paddr_sampler | paddr_computer;
assign pwdata_mem = pwdata_sampler | pwdata_computer;
assign pwrite_mem = pwrite_sampler | pwrite_computer;

sampler sampler(
	.pclk(pclk),
	.presetn(presetn),
	.data_i(data_i),
	.psel(psel_sampler),
	.penable(penable_sampler),
	.paddr(paddr_sampler),
	.pwdata(pwdata_sampler),
	.pwrite(pwrite_sampler),
	.pready(pready),
	.prdata(prdata)
);

computer computer (
	.pclk(pclk),
	.presetn(presetn),
	.compute_req(compute_req),
	.prdata(prdata),
	.pready(pready),
	.psel(psel_computer),
	.penable(penable_computer),
	.pwrite(pwrite_computer),
	.datao(datao),
	.valido(valido),
	.pwdata(pwdata_computer),
	.paddr(paddr_computer)

);

ram ram(
	.pclk(pclk),
	.presetn(presetn),
	.paddr(paddr_mem),
	.psel(psel_mem),
	.penable(penable_mem),
	.pwrite(pwrite_mem),
	.pwdata(pwdata_mem),
	.pready(pready),
	.prdata(prdata)

);


endmodule 
