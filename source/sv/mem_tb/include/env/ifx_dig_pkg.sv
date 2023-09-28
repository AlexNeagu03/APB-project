/******************************************************************************
 * (C) Copyright 2019 All Rights Reserved
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

package ifx_dig_pkg;



  //=========================================================================
  // UVM and DEFINES.
  //-------------------------------------------------------------------------
  //=========================================================================
  import uvm_pkg::*;
  `include  "uvm_macros.svh"

  `include "ifx_dig_defines.svh"

  //=========================================================================
  // import UVC packages 
  //-------------------------------------------------------------------------
  import ifx_dig_data_bus_uvc_pkg::*;

  //=========================================================================
  // Environment.
  //-------------------------------------------------------------------------
  //=========================================================================
 `include "ifx_dig_config.svh"
   typedef ifx_dig_env;
  //-- dig_env components 
  `include "ifx_dig_scoreboard.svh"
  `include "ifx_dig_env.svh"
  `include "ifx_dig_testbase.svh"
endpackage
