////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : top.sv
//Description	: TB Top
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

// RAM TB Top

`ifndef RAM_TOP
`define RAM_TOP

`include "../inc/ram_pkg.sv"

`timescale 1ns/1ps

import ram_pkg::*;

module top();
  
  bit clk, rstn;

  // Variable to hold the frequency from $plusargs
  real freq = 100.0; // Default frequency in MHz

  // Compute clock period based on frequency
  real clk_period; 
  real tclk_high; 
  real tclk_low;

  // Clock generation
  initial begin
    // Read clock frequency from $plusargs
    if ($value$plusargs("clk_freq=%f", freq)) begin
      $display("Clock frequency set to %f MHz", freq);
    end else begin
      $display("Using default clock frequency %f MHz", freq);
    end

    // Calculate clock period and duty cycle
    clk_period = 1.0 / freq * 1000; // Clock period in ns
    tclk_high = clk_period * 0.5;   // 50% Duty cycle
    tclk_low = clk_period - tclk_high;

    // Generate clock
    forever begin
      #tclk_low;
      clk = 1;
      #tclk_high;
      clk = 0;
    end
  end

  // Reset generation (Active-low reset)
  initial begin
    rstn = 1;
    #25;
    rstn = 0;  // Start with active low reset
    #25;       // Hold for 20 ns
    rstn = 1;  // Deassert reset
  end

  // Interface instantiation
  intf intff(clk, rstn);

  // Instantiate DUT
  single_port_ram_rtl dut(
    .clk(clk),
    .rstn(rstn),
    .en(intff.en),
    .wr_rd(intff.wr_rd),
    .addr(intff.addr),
    .din(intff.din),
    .valid(intff.valid),
    .dout(intff.dout),
    .ready(intff.ready),
    .error(intff.error)
  );

  // Test instance
  test t;

  // Test control
  initial begin
    config_db::vif = intff;
    // Instantiate and run the test
    t = new();
    t.run();
    
    #1000;
    $finish;
  end
endmodule

`endif
