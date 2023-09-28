module fsm
(

	input clk2,
	input pclk,
	input presetn,
	output reg [7:0] paddr,
	input [31:0] data_i,
	input pready,
	output reg psel,
	output reg penable,
	input [31:0] prdata, 
	output reg [31:0] pwdata,
	output reg pwrite
	
	
);

reg [1:0] current_state;
reg [1:0] next_state;
reg [7:0] current_addr;

localparam IDLE =2'b00;
localparam SETUP =2'b01;
localparam ACCESS =2'b10;

always @(posedge pclk or negedge presetn)
begin
if(~presetn)
begin
	current_state <= IDLE;
end
else current_state<=next_state;
end


always @(*)
begin
next_state = IDLE;
case(current_state)
	IDLE: if(clk2)
		next_state = SETUP;
	SETUP: next_state = ACCESS;
	ACCESS:if(~pready) next_state = ACCESS;
	default: next_state = IDLE;
endcase
end

always @(*) begin
	paddr = (current_state != IDLE) ? current_addr : 0;
	pwrite = (current_state != IDLE);
	psel= (current_state != IDLE);
	penable = (current_state == ACCESS);
	pwdata= data_i;
end

always @(posedge pclk or negedge presetn)
begin
if(~presetn) current_addr<=0;
else if (current_state == ACCESS && pready) current_addr <= current_addr + 1;
end
endmodule
