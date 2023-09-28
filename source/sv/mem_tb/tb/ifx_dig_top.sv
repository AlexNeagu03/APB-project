/******************************************************************************
 * (C) Copyright 2020 All Rights Reserved
 *
 * MODULE:
 * DEVICE:
 * PROJECT:
 * AUTHOR:
 * DATE:
 * FILE:
 * REVISION:
 *
 * FILE DESCRIPTION:
 *
 *******************************************************************************/

`include "ifx_dig_defines.svh"
`include  "uvm_macros.svh"

module ifx_dig_top;
//-----------------------------------------------------------------------------

  /// UVM import 
  import uvm_pkg::*;

  import ifx_dig_data_bus_uvc_pkg::*;
  import ifx_dig_pkg::*;
  import ifx_dig_test_pkg::*;

  //===========================================================================
  // start UVM class environment - (uvm_test_top)
  //===========================================================================
  initial begin
    $timeformat(-9, 3, " ns", 15);// set time format.
    run_test();
  end

  //===========================================================================
  // wires connected to the RTL interface
  //===========================================================================
  //system clock & reset
  wire               clk_i_w;
  wire               rstn_i_w;

  //computing interface
  wire               compute_req_i_w;
  wire [`DWIDTH-1:0] data_o_w;
  wire               valid_o_w;

  //sampler interface
  wire [`DWIDTH-1:0] data_i_w;

  //===========================================================================
  // wires for other interconnection
  //===========================================================================

  //===========================================================================
  // clocks and extra wires
  //===========================================================================
  reg clk;

  //===========================================================================
  // Connection to DUT
  //===========================================================================
  
  // HINT --  add here instance for DUT
  top2 top2(
    .pclk(clk_i_w),
    .presetn(rstn_i_w),
    .compute_req(compute_req_i_w),
    .data_i(data_i_w),
    .datao(data_o_w),
    .valido(valid_o_w)
  );

  //===========================================================================
  //              INTERFACES
  //===========================================================================

  // HINT --  add here instance for dig_if
 

  //===========================================================================
  // interconnect module and/or interface UVCs
  //===========================================================================
  // interfaces for UVCs

  // HINT --  add here instance for rstn_i_if, compute_req_i_if and data_i_if
  ifx_dig_data_bus_uvc_interface #(`DWIDTH_1) rstn_i_if(
    .clk_i(clk_i_w),
    .data(rstn_i_w)
  );

  ifx_dig_data_bus_uvc_interface #(`DWIDTH_1) compute_req_i_if(
    .clk_i(clk_i_w),
    .data(compute_req_i_w)
  );

  ifx_dig_data_bus_uvc_interface #(`DWIDTH_32) data_i_if(
    .clk_i(clk_i_w),
    .data(data_i_w)
  );

  ifx_dig_interface dig_if(
    .clk_i(clk_i_w),
    .rstn_i(rstn_i_w),
    .data_i(data_i_w),
    .data_o(data_o_w),
    .compute_req_i(compute_req_i_w),
    .valid_o(valid_o_w)
  
  );
  //Initialize System Signals
  initial begin
    clk = 0;
  end
  //===========================CLOCKS=============================
  always begin
    #500 clk = ~clk;
  end

  assign clk_i_w = clk;

  //===========================================================================
  // pass virtual interfaces to the testbench
  //===========================================================================

  initial begin
    //----------DIG-----------
    uvm_config_db #(virtual ifx_dig_interface)::set(uvm_top, "*", "dig_if", dig_if);

    // interfaces for UVCs
    uvm_config_db #(virtual ifx_dig_data_bus_uvc_interface#(.DWIDTH(`DWIDTH_1)))::set(uvm_top, "rstn_i_agt", "vif", rstn_i_if);
    uvm_config_db #(virtual ifx_dig_data_bus_uvc_interface#(.DWIDTH(`DWIDTH_1)))::set(uvm_top, "compute_req_i_agt", "vif", compute_req_i_if);
    uvm_config_db #(virtual ifx_dig_data_bus_uvc_interface#(.DWIDTH(`DWIDTH_32)))::set(uvm_top, "data_i_agt", "vif", data_i_if);

  end
endmodule
