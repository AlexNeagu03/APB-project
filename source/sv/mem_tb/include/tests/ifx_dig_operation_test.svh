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

class ifx_dig_operation_test extends ifx_dig_testbase;

  `uvm_component_utils(ifx_dig_operation_test)

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

  function new(string name = "ifx_dig_operation_test", uvm_component parent);
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

    `uvm_info(get_full_name(), "================ OPERATION TEST ==================", UVM_NONE)

    `uvm_info(get_type_name(), " Send a simple reset seq", UVM_NONE)
    rstn_i_seq.duration_ns = $urandom_range(1000, 2000);
    rstn_i_seq.start(dig_env.rstn_i_agt.sequencer);

    // HINT --  send random data_i sequences
  
	`uvm_info(get_type_name(), "Send random data", UVM_NONE)
	data_i_seq.data =   32'h5555_5555;
	data_i_seq.start(dig_env.data_i_agt.sequencer);
  `WAIT_MS(1.5)
	data_i_seq.data =   32'h1234_4321;
	data_i_seq.start(dig_env.data_i_agt.sequencer);
    `WAIT_MS(3)
    // HINT --  send random compute_req_i sequences
	`uvm_info(get_type_name(), " Send a compute request seq", UVM_NONE)
    compute_req_i_seq.duration_ns = 1000;
    compute_req_i_seq.start(dig_env.compute_req_i_agt.sequencer);

    `WAIT_MS(1.5)

    phase.drop_objection(this);
  endtask

endclass

