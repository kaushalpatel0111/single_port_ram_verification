`ifndef RAM_PKG
`define RAM_PKG

`include "define.sv"
`include "interface.sv"

package ram_pkg;
    `include "transaction.sv"
    `include "config_db.sv"
    `include "generator.sv"
    `include "driver.sv"
    `include "coverage.sv"
    `include "monitor.sv"
    `include "../test/err_handling.sv"
    `include "../test/b2b_wr_rd.sv"
    `include "../test/single_wr_rd.sv"
    `include "../test/multiple_wr_rd.sv"
    `include "../test/random_wr_rd.sv"
    `include "agent.sv"
    `include "scoreboard.sv"
    `include "environment.sv"
    `include "../test/test.sv"
endpackage

`endif
