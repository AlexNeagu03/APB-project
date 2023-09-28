`timescale 1us/100ns

module testbench();
reg compute_req;
reg clk_i;
reg rstn_i;
reg [31:0] data_i;
reg [31:0] datao;
reg valido; 
integer i;



top2 top2(
	.pclk(clk_i),
	.compute_req(compute_req),
	.presetn(rstn_i),
	.data_i(data_i),
	//.pready(pready_i),
	.datao(datao),
 	.valido(valido)	
);

initial begin
	clk_i = 0;
	forever #0.5 clk_i = ~clk_i;	
end

initial begin 
	rstn_i = 1;
	compute_req = 0;	
	#1 rstn_i = 0;
	#1 rstn_i =1;
	#10 data_i = 32'd23;
	for (i = 1 ; i < 256 ; i = i + 1 )
		#1000 data_i = data_i + 1;

	#1000;	
	#20 compute_req = 1;
	#1 compute_req = 0;
	#2000 compute_req = 1;
	#1 compute_req = 0;
	#1000 $stop;
	
end

endmodule
