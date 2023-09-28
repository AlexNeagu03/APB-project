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
 
class ifx_dig_data_bus_uvc_monitor#(int DWIDTH = 32) extends uvm_monitor;

  `uvm_component_utils(ifx_dig_data_bus_uvc_monitor#(DWIDTH))

  string agent_name;
  virtual interface ifx_dig_data_bus_uvc_interface#(DWIDTH) vif;
  ifx_dig_data_bus_uvc_config cfg;

  ifx_dig_data_bus_uvc_seq_item mon_item;

  uvm_analysis_port #(ifx_dig_data_bus_uvc_seq_item) mon_port;

  function new(string name,uvm_component parent);
    super.new(name,parent);
    mon_port=new("mon_port",this);
  endfunction

  function void build_phase(uvm_phase phase);
    mon_item = ifx_dig_data_bus_uvc_seq_item::type_id::create("mon_item", this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "Starting the run() phase", UVM_MEDIUM)

    forever begin
      @(vif.data) begin
        `uvm_info(get_type_name(), "Detected Signal change", UVM_MEDIUM)
        mon_item.data = vif.data;
       // @(posedge vif.clk_i);
        mon_port.write(mon_item);// sent collected item outside the monitor
      end
    end

  endtask
endclass
