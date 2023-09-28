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

class ifx_dig_data_bus_uvc_config extends uvm_object;

  `uvm_object_utils(ifx_dig_data_bus_uvc_config)

  string name;

  signal_active_level_t active_lvl;
  bit                   is_single_wire_b = 1;


  function new (string name = "signal_config");
    super.new(name);
  endfunction

endclass