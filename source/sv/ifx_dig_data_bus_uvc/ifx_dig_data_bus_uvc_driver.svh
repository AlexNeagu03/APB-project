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
 
class ifx_dig_data_bus_uvc_driver#(int DWIDTH = 32) extends uvm_driver #(ifx_dig_data_bus_uvc_seq_item);

  `uvm_component_utils(ifx_dig_data_bus_uvc_driver#(DWIDTH))

  virtual interface ifx_dig_data_bus_uvc_interface#(DWIDTH) vif;

  ifx_dig_data_bus_uvc_config cfg;

  string agent_name;

  //Constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //Build Phase
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
  endfunction

  //Run Phase
  virtual task run_phase (uvm_phase phase);

    // initial set to inactive level
    send_signal_off();

    forever begin
      // get the next item from the sequencer
      seq_item_port.get_next_item(req);
	
      if(cfg.is_single_wire_b) begin
	if(req.toggle_only_b) begin
		vif.data = ~vif.data;
	end
      else begin
        send_signal_on();
        wait_delay(req.duration_ns);
        send_signal_off();
      end
      end
      else begin
        send_data();
      end
      // tell the sequence the current item driving has finished
      seq_item_port.item_done();
    end
  endtask

// tasks used for driving
  task wait_delay(int unsigned duration_ns);
    for(int i=0;i<duration_ns;i++) begin
      #1ns;
	  end
  endtask

  task send_signal_on();
    `uvm_info (get_type_name(), "Signal on ON level", UVM_MEDIUM)
    vif.data= cfg.active_lvl; // implicit cast, 0-ACTIVE_0, 1-ACTIVE_1
  endtask

  task send_signal_off();
    `uvm_info (get_type_name(), "Signal on OFF level", UVM_MEDIUM)
    vif.data= cfg.active_lvl == ACTIVE_0 ? 1 : 0;
  endtask

  task send_data();
    `uvm_info (get_type_name(), "Send data", UVM_MEDIUM)
    vif.data = req.data;
  endtask


endclass
