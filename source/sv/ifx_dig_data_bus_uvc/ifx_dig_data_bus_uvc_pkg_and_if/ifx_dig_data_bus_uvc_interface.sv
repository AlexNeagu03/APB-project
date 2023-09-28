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
 
interface ifx_dig_data_bus_uvc_interface #(int DWIDTH = 1)
(
    input  bit              clk_i,
    output bit[DWIDTH-1:0] data
);

endinterface
