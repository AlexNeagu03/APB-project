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
 
/// very simple sequence - it generates only one transaction to the driver
class ifx_dig_data_bus_uvc_sequence extends uvm_sequence #(ifx_dig_data_bus_uvc_seq_item);

  `uvm_object_utils(ifx_dig_data_bus_uvc_sequence)

  ifx_dig_data_bus_uvc_seq_item seq_item;

  bit[`DWIDTH-1:0] data;
  int              duration_ns;
  bit              is_random_b;
  bit 		   toggle_only_b;
  //Constructor
  function new(string name="");
    super.new(name);
  endfunction

  virtual task body ();
    `uvm_info(get_type_name(), $sformatf("Executing sequence with parameters data=%0d", data), UVM_MEDIUM)

    `uvm_create(seq_item)// create the object
    if (is_random_b) begin
      void'(seq_item.randomize());
    end
    else begin
      seq_item.data        = data;
      seq_item.duration_ns = duration_ns;
    end
	if(toggle_only_b)
	begin
	seq_item.toggle_only_b = toggle_only_b;
	end
    `uvm_send(seq_item) // send the object to the sequencer

    `uvm_info(get_type_name()," Item finished ", UVM_MEDIUM)
  endtask

endclass


