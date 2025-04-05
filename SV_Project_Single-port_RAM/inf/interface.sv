////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : interface.sv
//Description	: Interface
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

// RAM Interface

`ifndef RAM_INTERFACE
`define RAM_INTERFACE

`timescale 1ns/1ps

interface intf(input logic clk, rstn);
  logic                    en;
  logic                    wr_rd;
  logic  [`ADDR_WIDTH-1:0] addr;
  logic  [`DATA_WIDTH-1:0] din;
  logic                    valid;
  logic  [`DATA_WIDTH-1:0] dout;
  logic                    ready;
  logic                    error;

  // Clocking block for driver
  clocking drv_cb @(posedge clk);
    default input #`IN_SKEW output #`OUT_SKEW;
    output en;
    output wr_rd;
    output addr;
    output din;
    output valid;
    input dout;
    input ready;
    input error;
  endclocking
  
  // Clocking block for monitor
  clocking mon_cb @(posedge clk);
    default input #`IN_SKEW output #`OUT_SKEW;
    input en;
    input wr_rd;
    input addr;
    input din;
    input valid;
    input dout;
    input ready;
    input error;
  endclocking
  
  // Modports
  modport driver (clocking drv_cb, input clk, rstn);
  modport monitor (clocking mon_cb, input clk, rstn);
endinterface

`endif
