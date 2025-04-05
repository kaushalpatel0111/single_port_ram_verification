//RAM RTL
`ifndef RAM_DUT
`define RAM_DUT

//RAM 32x32
`define ADDR_WIDTH 5
`define DATA_WIDTH 32
`define MEM_DEPTH 32  // MEM_DEPTH = 2 ^ ADDR_WIDTH

module single_port_ram_rtl (
    input clk,
    input rstn,    // Active-low reset
    input en,
    input wr_rd,   // 1 for write, 0 for read
    input [`ADDR_WIDTH-1:0] addr,
    input [`DATA_WIDTH-1:0] din,
    input valid,
    output reg [`DATA_WIDTH-1:0] dout,
    output reg ready,
    output reg error
);

    // Memory array
    reg [`DATA_WIDTH-1:0] mem [`MEM_DEPTH-1:0];

    // For array declaration
    integer i;
    
    always @(posedge clk or negedge rstn) begin
//      $display("MEM_PRINT: %0p",mem);
      if (!rstn) begin
        // Reset state
        for(i=0;i<`MEM_DEPTH;i=i+1)begin
            mem[i] <= 0;
        end
        dout <= 0;
        ready <= 0;
        error <= 0;
      end
      else begin
        if (en) begin
          if (^din === 1'bx || ^din === 1'bz || ^addr === 1'bx || ^addr === 1'bz) begin
            // Check for 'x' or 'z' in din
            dout <= 0;
            ready <= 1;
            error <= 1;
          end else if (valid) begin
            // Valid signal from master
            if (wr_rd) begin
              // Write operation
              mem[addr] <= din;
              error <= 0;
              ready <= 1;
            end else begin
              // Read operation
              dout <= mem[addr];
              error <= 0;
              ready <= 1;
            end
          end else begin
            // Valid signal not asserted
            ready <= 0;
          end
        end else begin
          ready <= 0;
          error <= 0;
        end
      end
    end
endmodule

`endif
