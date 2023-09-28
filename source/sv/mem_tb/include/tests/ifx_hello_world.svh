/******************************************************************************
 * (C) Copyright 2020 All Rights Reserved
 *
 * MODULE:
 * DEVICE:
 * PROJECT: PIT_TRAIN
 * AUTHOR:
 * DATE:
 * FILE:
 * REVISION:
 *
 * FILE DESCRIPTION:
 *
 *******************************************************************************/

class ifx_hello_world extends ifx_dig_testbase;

  `uvm_component_utils(ifx_hello_world)

  //=========================================================================
  // Sequences and variables.

  //=========================================================================
  // Test controls.
  //-------------------------------------------------------------------------
  //=========================================================================

  //=========================================================================
  // Functions and phases.
  //-------------------------------------------------------------------------
  //=========================================================================

  function new(string name = "ifx_hello_world", uvm_component parent);
    super.new(name, parent);
  // create the sequences using factory
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

  endfunction : build_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info(get_full_name(), "=== RUN PHASE STARTING ===", UVM_NONE)
  endtask

  task main_phase(uvm_phase phase);

    phase.raise_objection(this);

    `uvm_info(get_full_name(), "================HELLO WORLD!! ==================", UVM_NONE)

   

    // HINT --  send random data_i sequences
   

    `WAIT_US(1)
    
    // HINT --  send random compute_req_i sequences


    `WAIT_MS(1)

    phase.drop_objection(this);
  endtask

endclass

