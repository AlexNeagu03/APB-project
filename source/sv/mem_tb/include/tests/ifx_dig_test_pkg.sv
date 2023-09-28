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
 
`timescale 1ns/100ps

package ifx_dig_test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import ifx_dig_data_bus_uvc_pkg::*;
  import ifx_dig_pkg::*;

  // HINT --  add here include for simple hello world test 
    `include "ifx_toggle.svh"
  //`include "ifx_forktest.svh"
  //`include "ifx_dig_simple_test.svh"
  //`include "ifx_hello_world.svh"
  //`include "ifx_dig_operation_test.svh"
  //`include "ifx_dig_rand_operation.svh"
endpackage
