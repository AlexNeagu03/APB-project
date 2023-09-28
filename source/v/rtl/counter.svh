module counter(
	input pclk,
	input presetn,
	output value

);

reg [9:0] count; 

always @(posedge pclk or negedge presetn)
begin
if (~presetn )
	count<= 0;
else if (count == 999)
	count<= 0;
	else count <= count + 1;

end
assign value = count==999 ? 1 : 0; 
endmodule
