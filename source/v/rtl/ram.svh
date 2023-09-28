
module ram
(
	input pclk,
	input presetn,
	input [7:0] paddr,
	input psel,
	input penable,
	input pwrite,
	input [31:0] pwdata,
	output pready,
	output  [31:0] prdata
);

reg [31:0] mem [0:255];

localparam IDLE = 2'b00;
localparam SETUP = 2'b01;
localparam ACCESS = 2'b10;

reg [1:0] current_state;
reg [1:0] next_state;

always @(posedge pclk or negedge presetn)
begin 
if(~presetn)
	current_state <= IDLE;
else 
	current_state <= next_state;
end

always @(*)
begin
next_state = IDLE;
case(current_state)
	IDLE: if(psel && ~penable) next_state = SETUP;
	SETUP: if(psel && penable) next_state = ACCESS;
	ACCESS:next_state = IDLE;
	default: next_state = IDLE;
endcase
end

always @(posedge pclk) begin

if(current_state == SETUP && pwrite)
begin
	mem [paddr] = pwdata;	
	
end
end
assign prdata = (current_state == ACCESS && ~pwrite) ? mem[paddr]: 0;

assign pready = (current_state !== SETUP);

endmodule

