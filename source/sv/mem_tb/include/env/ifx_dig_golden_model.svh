///******************************************************************************
// * (C) Copyright 2020 All Rights Reserved
// *
// * MODULE:
// * DEVICE:
// * PROJECT:
// * AUTHOR:
// * DATE:
// * FILE:
// * REVISION:
// *
// * FILE DESCRIPTION:
// *
// *******************************************************************************/

logic[`DWIDTH-1:0] mem[0:255];
logic[`DWIDTH-1:0] data_i;
logic[`DWIDTH-1:0] expected_data_o;
bit  [7:0]         current_sample_address;
bit  [7:0]         current_compute_address;
bit                expected_valid_o;
bit                compute_req_b;
bit                reset_b;
bit 		   	   compute_req_sync;
task sample_data();

  forever begin
    int cnt=0;
    while ((reset_b == 1) && cnt <=1000) begin				
	    // HINT -- add here code to wait 1us 
	`WAIT_US(1)
      cnt++;
    end
    if (reset_b == 1) begin
      mem[current_sample_address] = data_i;
      cover_data.sample();
      current_sample_address++;
    end
    else @(posedge reset_b)begin
	current_sample_address = 0;
	current_compute_address = 0;
end
  end

endtask

task set_expected_data();

  forever @(posedge compute_req_sync) begin
	  // HINT -- add here code to set expected_data_o

    `WAIT_US(5)
	if(reset_b) begin
    expected_data_o = mem[current_compute_address] + mem[current_compute_address +1]; 
    cover_data.sample();
    current_compute_address = current_compute_address + 2;
  end
end
endtask

task set_expected_validity();
fork

  forever @(posedge compute_req_sync) begin
    // HINT --  add here code to set expected_valid_o
	if(reset_b) begin
    `WAIT_US(5)
     expected_valid_o = 1;
    `WAIT_US(1)
     expected_valid_o = 0;
		end
  end
	forever@(compute_req_b) begin
	@(posedge dig_vif.clk_i)
	compute_req_sync = compute_req_b;
end
join
endtask
