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

//=========================================================================
// Environment and tests.
//-------------------------------------------------------------------------
//=========================================================================


`define WAIT_NS(TIME) #(``TIME``*1ns);
`define WAIT_US(TIME) #(``TIME``*1us);
`define WAIT_MS(TIME) #(``TIME``*1ms);
`define WAIT_PS(TIME) #(``TIME``*1ps);


/////////////////////  Add your defines below ////////////////////////////////

`define DWIDTH    32    // Data bus width
`define DWIDTH_1  1
`define DWIDTH_32 32