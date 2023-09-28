/******************************************************************************
 * (C) Copyright 2019 All Rights Reserved
 *
 * MODULE:
 * DEVICE:
 * PROJECT: mercury
 * AUTHOR: 
 * DATE:
 * FILE:
 * REVISION:
 *
 * FILE DESCRIPTION: Digital module DUT interface
 *
 *******************************************************************************/

`include "ifx_dig_defines.svh"

interface ifx_dig_interface (

  //system clock & reset
  input bit clk_i,          // clock input
  input bit rstn_i,         //synchronous active high reset 

  //computing interface
  input logic[`DWIDTH-1:0] data_o,
  input bit compute_req_i,
  input bit valid_o,

  //sampler interface
  input bit[`DWIDTH-1:0] data_i
);

endinterface
