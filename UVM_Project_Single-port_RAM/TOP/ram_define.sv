// RAM Define
`ifndef RAM_DEFINE
`define RAM_DEFINE

`define ADDR_WIDTH 5
`define DATA_WIDTH 32
`define MEM_DEPTH 32  // MEM_DEPTH = 2 ^ ADDR_WIDTH
`define IN_SKEW 1     // Clocking block skew to avoid setup violation
`define OUT_SKEW 1    // Clocking block skew to avoid hold violation

`endif
