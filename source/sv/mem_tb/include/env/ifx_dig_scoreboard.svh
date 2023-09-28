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

class ifx_dig_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(ifx_dig_scoreboard)

  //=========================================================================
  // Pointers.
  //-------------------------------------------------------------------------
  //=========================================================================
  ifx_dig_env p_env; //-- pointer to the ENV
  ifx_dig_config p_env_cfg;
  virtual ifx_dig_interface dig_vif;
  //=========================================================================
  // Components.
  //-------------------------------------------------------------------------
  //=========================================================================

  //=========================================================================
  // Golden interface.
  //-------------------------------------------------------------------------
  //=========================================================================


  //=========================================================================
  // TLM imports
  //-------------------------------------------------------------------------
  //=========================================================================
  
  `uvm_analysis_imp_decl(_rstn_i)
  uvm_analysis_imp_rstn_i #(ifx_dig_data_bus_uvc_seq_item, ifx_dig_scoreboard) rstn_i_imp;

  `uvm_analysis_imp_decl(_compute_req_i)
  uvm_analysis_imp_compute_req_i #(ifx_dig_data_bus_uvc_seq_item, ifx_dig_scoreboard) compute_req_i_imp;

  `uvm_analysis_imp_decl(_data_i)
  uvm_analysis_imp_data_i #(ifx_dig_data_bus_uvc_seq_item, ifx_dig_scoreboard) data_i_imp;

  //=========================================================================
  // Signals, variables, methods PER FEATURE.
  //-------------------------------------------------------------------------
  //=========================================================================

  //=========================================================================
  // COVERAGE.
  //-------------------------------------------------------------------------
  //=========================================================================

  //=========================================================================
  // UVM PHASING.
  //-------------------------------------------------------------------------
  //=========================================================================

  extern function new(string name = "ifx_dig_scoreboard", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

//=========================================================================
// ENVIRONMENT SYNC and OTHER TASKS.
//-------------------------------------------------------------------------
//=========================================================================

`include "ifx_dig_golden_model.svh"
`include "ifx_dig_checkers.svh"
`include "ifx_dig_coverage.svh"

  function void write_rstn_i(input ifx_dig_data_bus_uvc_seq_item packet);
    begin
      `uvm_info("WRITE_RSTN_I", $sformatf("Received packet from RSTN_I monitor. \n"), UVM_NONE)
      // HINT --  pass here value for reset_b global variable
      reset_b = bit'(packet.data);
    end
  endfunction: write_rstn_i


  function void write_compute_req_i(input ifx_dig_data_bus_uvc_seq_item packet);
    begin
      `uvm_info("WRITE_COMPUTE_REQ_I", $sformatf("Received packet from COMPUTE_REQ_I monitor. \n"), UVM_NONE)
      // HINT --  pass here value for compute_req_b global variable
      compute_req_b = bit'(packet.data);
    end
  endfunction: write_compute_req_i

  function void write_data_i(input ifx_dig_data_bus_uvc_seq_item packet);
    begin
      `uvm_info("WRITE_DATA_I", $sformatf("Received packet from DATA_I monitor. \n"), UVM_NONE)
      // HINT --  pass here value for data_i global variable
      data_i = 32'(packet.data);
    end
  endfunction: write_data_i

endclass : ifx_dig_scoreboard


//=========================================================================
// Method implementation.
//-------------------------------------------------------------------------
//=========================================================================

function ifx_dig_scoreboard::new(string name = "ifx_dig_scoreboard", uvm_component parent);
	super.new(name, parent);

//=========================================================================
//  COVERAGE INITIALIZATION.
//-------------------------------------------------------------------------
//=========================================================================
  this.cover_data        = new();

//=========================================================================
//  TLM IMPORT INITIALIZATION.
//-------------------------------------------------------------------------
//=========================================================================

  rstn_i_imp        = new("rstn_i_imp", this);
  compute_req_i_imp = new("compute_req_i_imp", this);
  data_i_imp        = new("data_i_imp", this);

endfunction : new


function void ifx_dig_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(virtual ifx_dig_interface)::get(this, "", "dig_if", dig_vif))
    `uvm_fatal("TEST_BASE/NOVIF", "No virtual interface specified for SCOREBOARD")
`uvm_info(get_name(), "ENV build_phase done", UVM_LOW)
endfunction : build_phase

function void ifx_dig_scoreboard::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
`uvm_info(get_name(), "ENV connect_phase done", UVM_LOW)
endfunction : connect_phase

function void ifx_dig_scoreboard:: end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
`uvm_info(get_name(), "ENV end_of_elaboration_phase done", UVM_LOW)
endfunction : end_of_elaboration_phase

task ifx_dig_scoreboard::run_phase(uvm_phase phase);

  fork
    // Golden Model
    sample_data();
    set_expected_data();
    set_expected_validity();

     //Checkers
    check_data_o();
    check_valid_o();
 join
`uvm_info(get_name(), "ENV run_phase done", UVM_LOW)
endtask : run_phase

//=========================================================================
// Include EXTERNAL method implementation files.
//-------------------------------------------------------------------------
//=========================================================================

