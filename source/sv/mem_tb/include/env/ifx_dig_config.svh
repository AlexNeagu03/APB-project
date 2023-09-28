/******************************************************************************
 * (C) Copyright 2019 All Rights Reserved
 *
 * MODULE:
 * DEVICE:
 * PROJECT:
 * AUTHOR:
 * DATE:
 * FILE: ifx_dig_defines
 * REVISION:
 *
 * FILE DESCRIPTION:
 *
 *******************************************************************************/
typedef ifx_dig_env;

class ifx_dig_config extends uvm_object;

  `uvm_object_utils(ifx_dig_config)

  //=========================================================================
  // UVC configurations.
  //-------------------------------------------------------------------------
  //=========================================================================

  // HINT -- add here declarations for rstn_i, compute_req and data_i configs

	ifx_dig_data_bus_uvc_config rstn_i_cfg;
	ifx_dig_data_bus_uvc_config compute_req_i_cfg;
	ifx_dig_data_bus_uvc_config data_i_cfg;

  //=========================================================================
  // Pointers.
  //-------------------------------------------------------------------------
  //=========================================================================
  ifx_dig_env   p_env;

  //=========================================================================
  // Interfaces.
  //-------------------------------------------------------------------------
  //=========================================================================
  virtual interface   ifx_dig_interface   dig_vif;

  //=========================================================================
  // Constraints.
  //-------------------------------------------------------------------------
  //=========================================================================

  //=========================================================================
  // Methods.
  //-------------------------------------------------------------------------
  //=========================================================================
  function new( string name = "ifx_dig_config" );
    super.new(name);

    // create sub-configurations
    // HINT --  create here instances for rstn_i, compute_req and data_i configs
	rstn_i_cfg= ifx_dig_data_bus_uvc_config::type_id::create("rstn_i_cfg");
	compute_req_i_cfg= ifx_dig_data_bus_uvc_config::type_id::create("compute_req_i_cfg");
	data_i_cfg= ifx_dig_data_bus_uvc_config::type_id::create("data_i_cfg");

    initialize_configs();
  endfunction : new

  function void initialize_configs();

    // config set 
    compute_req_i_cfg.active_lvl = ACTIVE_1;
    compute_req_i_cfg.is_single_wire_b = 1;

  // HINT --  set here values for rstn_i and data_i configs
    rstn_i_cfg.active_lvl = ACTIVE_0;
    rstn_i_cfg.is_single_wire_b = 1;	

    data_i_cfg.active_lvl = ACTIVE_1;
    data_i_cfg.is_single_wire_b = 0;

  endfunction

endclass// ifx_dig_config
