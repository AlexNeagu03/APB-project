module computer(
	input pclk,
	input presetn,
	input compute_req,
	input [31:0] prdata,
	input pready,
	output reg psel,
	output reg penable,
	output reg pwrite,
	output [31:0] datao ,
	output valido,
	output reg [31:0] pwdata,
	output [7:0] paddr
	
);

reg [1:0] current_state;
reg [1:0] next_state;
reg [7:0] counter_addr;
reg [31:0] prev_data;


localparam IDLE =2'b00;
localparam SETUP =2'b01;
localparam ACCESS =2'b10;

always @(posedge pclk or negedge presetn)
begin
if(~presetn)
	current_state <= IDLE;
else 
	current_state <= next_state;

end 

always @(*)
begin
next_state =IDLE;
case (current_state)
	IDLE: if (compute_req) next_state = SETUP;
	SETUP: next_state = ACCESS;
	ACCESS: if(pready && counter_addr[0] == 0) next_state = SETUP;
							
		else if(pready && counter_addr[0] != 0 ) next_state = IDLE;
		else next_state = ACCESS;
						
endcase
end


always @(posedge pclk or negedge presetn)

begin
if(~presetn)
	begin
	counter_addr <= 0;
	prev_data <= 0;
end
else if (current_state == ACCESS && pready)
	begin
	counter_addr <= counter_addr + 1;
	prev_data <= prdata;

end
end


assign datao = prev_data + prdata ;

assign valido = (current_state == ACCESS && pready && counter_addr[0] != 0) ? 1 : 0;

always @(*)
begin
pwrite = 0;
psel = (current_state != IDLE);
penable = (current_state == ACCESS);
pwdata = 0;
end

assign paddr = (current_state != IDLE ) ? counter_addr: 0 ;
endmodule 
