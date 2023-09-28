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

class ifx_dig_testbase extends uvm_test;

  `uvm_component_utils(ifx_dig_testbase)
	ifx_dig_env             dig_env;
 	ifx_dig_config          dig_cfg;



  // HINT --  add here declaration for dig_env
  

  //=========================================================================
  // Sequences.
  //-------------------------------------------------------------------------
  //=========================================================================


  ifx_dig_data_bus_uvc_sequence rstn_i_seq;
  // HINT --  add here declarations for compute_req_i_seq and data_i_seq
  ifx_dig_data_bus_uvc_sequence compute_req_i_seq;
  ifx_dig_data_bus_uvc_sequence data_i_seq;

  //=========================================================================
  // Variables.
  //-------------------------------------------------------------------------
  //=========================================================================

  uvm_report_server report_server;// used to display relevant info at the end of the test
  //=========================================================================
  // Methods.
  //-------------------------------------------------------------------------
  //=========================================================================
  extern function new(string name = "ifx_dig_testbase", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern task reset_phase(uvm_phase phase);

  extern virtual task run_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);

//=========================================================================
// GENERAL METHODS for STIMULI.
//-------------------------------------------------------------------------
//=========================================================================

endclass: ifx_dig_testbase


//=========================================================================
// Method implementation.
//-------------------------------------------------------------------------
//=========================================================================
function ifx_dig_testbase::new(
    string        name = "ifx_dig_testbase",
    uvm_component parent = null
  );
  super.new(name, parent);
endfunction : new


task ifx_dig_testbase::reset_phase(uvm_phase phase);
endtask : reset_phase

// Hook that can be overloaded in sub-classes to add configuration statements
//-----------------------------------------------------------------------------

function void ifx_dig_testbase::build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_name(), "ENV build_phase done", UVM_LOW)

  //------------------=====================================---------------
  //-=========================- CREATE CONFIGURATION OBJECT -=========================-
  //------------------=====================================---------------
  dig_cfg = ifx_dig_config::type_id::create("dig_cfg", this);

  //------------------=====================================---------------
  //-=========================- INTERFACE GET -=========================-
  //------------------=====================================---------------
  //-----------Digital interface-----------
 if (!uvm_config_db#(virtual ifx_dig_interface)::get(this, "", "dig_if", dig_cfg.dig_vif))
    `uvm_fatal("TEST_BASE/NOVIF", "No virtual interface specified for TEST BASE")

  //------------------=====================================---------------
  //-=========================- CREATE ENV  -=========================-
  //------------------=====================================---------------
  dig_env = ifx_dig_env::type_id::create("dig_env", this);

  //------------------=====================================---------------
  //-=========================- SET CONFIGURATION OBJECTS -=========================-
  //------------------====================/******************************************************************************=================---------------
  uvm_config_db #(ifx_dig_config)::set(this, "*", "p_dig_cfg", dig_cfg);

  //configuration objects for their corresponding agents
  uvm_config_db #(ifx_dig_data_bus_uvc_config)::set(uvm_top, "rstn_i_agt" , "cfg", dig_cfg.rstn_i_cfg);
  uvm_config_db #(ifx_dig_data_bus_uvc_config)::set(uvm_top, "compute_req_i_agt" , "cfg", dig_cfg.compute_req_i_cfg);
  uvm_config_db #(ifx_dig_data_bus_uvc_config)::set(uvm_top, "data_i_agt" , "cfg", dig_cfg.data_i_cfg);

  //------------------=====================================---------------
  //-=========================- CREATE SEQUENCES -=========================-
  //------------------=====================================---------------

  rstn_i_seq        = ifx_dig_data_bus_uvc_sequence::type_id::create("rstn_i_seq", this);
  // HINT --  create here instances for compute_req_i_seq and data_i_seq
  compute_req_i_seq = ifx_dig_data_bus_uvc_sequence::type_id::create("compute_req_i_seq",this);
  data_i_seq = ifx_dig_data_bus_uvc_sequence::type_id::create("data_i_seq", this);

endfunction : build_phase

function void ifx_dig_testbase::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
`uvm_info(get_name(), "ENV connect_phase done", UVM_LOW)
// add necessary connections
endfunction

function void ifx_dig_testbase::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);

  // stop running after 1000 error
  set_report_severity_action_hier(UVM_ERROR, UVM_DISPLAY | UVM_COUNT);
  report_server = get_report_server();
  report_server.set_max_quit_count(1000); 
`uvm_info(get_name(), "ENV end_of_elaboration_phase done", UVM_LOW)

endfunction: end_of_elaboration_phase


function void ifx_dig_testbase::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
	`uvm_info(get_name(), "ENV start_of_simulation_phase done", UVM_LOW)
endfunction : start_of_simulation_phase

task ifx_dig_testbase:: run_phase(uvm_phase phase);
  super.run_phase(phase);
`uvm_info(get_name(), "ENV run_phase done", UVM_LOW)
endtask : run_phase

task ifx_dig_testbase::main_phase(uvm_phase phase);
  super.main_phase(phase);
`uvm_info(get_name(), "ENV main_phase done", UVM_LOW)
endtask : main_phase

//=========================================================================
// GENERAL METHODS for STIMULI.
//-------------------------------------------------------------------------
//=========================================================================
