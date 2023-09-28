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
 
class ifx_dig_data_bus_uvc_seq_item extends uvm_sequence_item;

  `uvm_object_utils(ifx_dig_data_bus_uvc_seq_item)

  rand bit[`DWIDTH-1:0] data;
  rand int              duration_ns;
  bit 		toggle_only_b;

  constraint duration {
    duration_ns >= 1000;
    duration_ns <= 5_000;
  }

  function new (string name="");
    super.new(name);
  endfunction

endclass
