// RAM Package
`ifndef RAM_PKG
`define RAM_PKG

`include "ram_define.sv"
`include "ram_interface.sv"

package ram_pkg;
    // uvm
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    // env
    `include "ram_seq_item.sv"
    `include "ram_sequence.sv"
    `include "ram_sequencer.sv"
    `include "ram_driver.sv"
    `include "ram_monitor.sv"
    `include "ram_agent.sv"
    `include "ram_scoreboard.sv"
    `include "ram_fc.sv"
    `include "ram_env.sv"

    // base test
    `include "ram_base_test.sv"

    // testcases
    `include "ram_single_wr_rd_test.sv"
    `include "ram_multi_wr_rd_test.sv"
    `include "ram_random_wr_rd_test.sv"
    `include "ram_b2b_wr_rd_test.sv"
    `include "ram_err_test.sv"
    `include "ram_in_bw_rst_test.sv"
endpackage

`endif
