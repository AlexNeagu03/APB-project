/******************************************************************************
 * (C) Copyright 2019 All Rights Reserved
 *
 * MODULE:
 * DEVICE:
 * PROJECT:
 * AUTHOR:
 * DATE:
 * FILE: ifx_dig_env
 * REVISION:
 *
 * FILE DESCRIPTION: digital tb environment
 *
 *******************************************************************************/

class ifx_dig_env extends uvm_env;

  //========= UVM UTILS MACRO ===========
  `uvm_component_utils(ifx_dig_env)

  //=========================================================================
  // Golden model instantiation.
  //-------------------------------------------------------------------------
  //=========================================================================
  ifx_dig_scoreboard scoreboard;

  //=========================================================================
  // UVC instantiation - COMMON for DIG & SOC.
  //-------------------------------------------------------------------------
  //=========================================================================


  //=========================================================================
  // Environment component instantiation.
  //-------------------------------------------------------------------------
  //=========================================================================
  ifx_dig_config p_dig_cfg;

  //=========================================================================
  // UVC instantiation.
  //-------------------------------------------------------------------------
  //=========================================================================

  ifx_dig_data_bus_uvc_agent#(`DWIDTH_1) rstn_i_agt;
  ifx_dig_data_bus_uvc_agent#(`DWIDTH_1) compute_req_i_agt;
  ifx_dig_data_bus_uvc_agent#(`DWIDTH_32) data_i_agt;

  //=========================================================================
  // Events and other variables
  //-------------------------------------------------------------------------
  //=========================================================================

  //=========================================================================
  // Methods.
  //-------------------------------------------------------------------------
  //=========================================================================
  function new(string name, uvm_component parent);
    super.new(name, parent);

  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info (get_type_name(), $sformatf(">>>>>>>>>>>>ENV BUILD_PHASE starts<<<<<<<<<"), UVM_LOW)

    //=======================COMPONENT CREATES======================
    scoreboard = ifx_dig_scoreboard::type_id::create("scoreboard", this);

    //=======================CONFIG SET COMPONENT SCOPE======================

    //=======================AGENT CREATES======================

    rstn_i_agt              = ifx_dig_data_bus_uvc_agent#(`DWIDTH_1)::type_id::create("rstn_i_agt", this);
    compute_req_i_agt       = ifx_dig_data_bus_uvc_agent#(`DWIDTH_1)::type_id::create("compute_req_i_agt", this);
    data_i_agt              = ifx_dig_data_bus_uvc_agent#(`DWIDTH_32)::type_id::create("data_i_agt", this);

  endfunction : build_phase


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    //=======================GOLDEN MODEL/MONITOR CONNECT======================
    scoreboard.p_env = this;
    scoreboard.p_env_cfg = p_dig_cfg;

    //=======================TLM======================
    // connect UVC tlm ports

    rstn_i_agt.monitor.mon_port.connect(scoreboard.rstn_i_imp);
 
    // HINT --  add here connections for compute_req and data_i TLM ports
    `uvm_info(get_name(), "ENV connect_phase done", UVM_LOW)
    compute_req_i_agt.monitor.mon_port.connect(scoreboard.compute_req_i_imp);
    data_i_agt.monitor.mon_port.connect(scoreboard.data_i_imp);
  endfunction : connect_phase


  function void start_of_simulation_phase(uvm_phase phase);
`uvm_info(get_name(), "ENV start_of_simulation_phase done", UVM_LOW)
  endfunction : start_of_simulation_phase

  task reset_phase(uvm_phase phase);
    super.reset_phase(phase);
`uvm_info(get_name(), "ENV reset_phase done", UVM_LOW)
  endtask : reset_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info (get_type_name(), $sformatf(">>>>>>>>>>>>ENV RUN_PHASE starts<<<<<<<<<"), UVM_LOW)


  endtask : run_phase

endclass
