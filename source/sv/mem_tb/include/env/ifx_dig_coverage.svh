/******************************************************************************
 * (C) Copyright 2019 All Rights Reserved
 *
 * MODULE:
 * DEVICE:
 * PROJECT:
 * AUTHOR:
 * DATE:
 * FILE: ifx_dig_defines
 * REVISION:
 *
 * FILE DESCRIPTION:
 *
 *******************************************************************************/

covergroup cover_data;

  option.per_instance = 1;
  option.name = "cover_data";

  // HINT --  add here coverpoints for data_i, current address and a cross between them
  data_cp : coverpoint data_i{
	bins all_zero = {'0};
	bins all_one = {'1};
	bins low = {[1:32'h00000eff]};
	bins med = {[32'h00000fff:32'h00efffff]};
	bins high = {[32'h00ffffff:32'hffffffff]};
}
  
  addr:coverpoint current_sample_address;

  compute_req_cp:coverpoint compute_req_b{
	bins compute_req_zero = {0};
	bins compute_req_one = {1};
}

compute_reqxaddr: cross addr, compute_req_cp;
endgroup

