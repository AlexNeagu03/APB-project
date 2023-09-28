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

class ifx_toggle extends ifx_dig_testbase;

  `uvm_component_utils(ifx_toggle)

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

  function new(string name = "ifx_toggle", uvm_component parent);
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
	int data;
    phase.raise_objection(this);

    `uvm_info(get_full_name(), "================ TOGGLE TEST ==================", UVM_NONE)

    `uvm_info(get_type_name(), " Send a simple reset seq", UVM_NONE)
    rstn_i_seq.duration_ns = $urandom_range(1000, 2000);
    rstn_i_seq.start(dig_env.rstn_i_agt.sequencer);

    `uvm_info(get_type_name(), "TOGGLE", UVM_NONE)
    rstn_i_seq.toggle_only_b  = 1;
    rstn_i_seq.start(dig_env.rstn_i_agt.sequencer);
    `WAIT_MS(1)	
    rstn_i_seq.toggle_only_b  = 1;
    rstn_i_seq.start(dig_env.rstn_i_agt.sequencer);

    // HINT --  send random data_i sequences
   repeat (256) begin
	`uvm_info(get_type_name(), "Send random data", UVM_NONE)
	std::randomize(data) with { data dist {0:= 20, 1:= 20, [1:32'h00000eff]:= 20, [32'h00000fff:32'h00efffff]:= 20, [32'h00ffffff:32'hffffffff] := 20};};
	data_i_seq.data = data;
	data_i_seq.start(dig_env.data_i_agt.sequencer);
`WAIT_US(1500)
	end
    `WAIT_US(500)
    
    // HINT --  send random compute_req_i sequences
	`uvm_info(get_type_name(), " Send a compute request seq", UVM_NONE)
    compute_req_i_seq.duration_ns = 1000;
    compute_req_i_seq.start(dig_env.compute_req_i_agt.sequencer);

    `WAIT_MS(1.5)
 
    	`uvm_info(get_type_name(), " Send a compute request seq", UVM_NONE)
    compute_req_i_seq.duration_ns = 1000;
    compute_req_i_seq.start(dig_env.compute_req_i_agt.sequencer);
  `WAIT_MS(1.5)
    rstn_i_seq.toggle_only_b  = 1;
    rstn_i_seq.start(dig_env.rstn_i_agt.sequencer);
   `WAIT_MS(1)	
    rstn_i_seq.toggle_only_b  = 1;
    rstn_i_seq.start(dig_env.rstn_i_agt.sequencer);
    `WAIT_MS(1)

    phase.drop_objection(this);

  endtask

endclass

