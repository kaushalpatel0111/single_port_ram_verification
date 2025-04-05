task rst_during_wr(
  output reg en,
  output reg wr_rd,
  output reg [4:0] addr,
  output reg [31:0] din,
  output reg valid,
  inout reg rstn,
  input [31:0] dout
);
    
  begin
    #10;
    en = 1;
    wr_rd = 1;
    addr = 5'b00010;
    din = 32'h2A2A2A2A;
    valid = 1;
  end
endtask

task rst_during_rd(
  output reg en,
  output reg wr_rd,
  output reg [4:0] addr,
  output reg [31:0] din,
  output reg valid,
  inout reg rstn,
  input [31:0] dout
);
  begin
    #10;
    rstn = 0; // Assert reset during write
    #10;
    rstn = 1;
    en = 1;
    wr_rd = 0;
    addr = 5'b00010;
    valid = 1;
    din = 32'h2A2A2A2A;
    #10;
    if (dout !== 32'h2A2A2A2A) $display("Test case rst_during_wr_rd failed");
  end
endtask