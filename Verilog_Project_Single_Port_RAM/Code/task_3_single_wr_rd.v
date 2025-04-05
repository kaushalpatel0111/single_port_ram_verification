task single_wr(
  output reg en,
  output reg wr_rd,
  output reg [4:0] addr,
  output reg [31:0] din,
  output reg valid,
  input [31:0] dout
);
  
  begin
    #10;
    en = 1;
    wr_rd = 1;
    addr = 5'b00011;
    din = 32'h3A3A3A3A;
    valid = 1;
  end
endtask

task single_rd(
  output reg en,
  output reg wr_rd,
  output reg [4:0] addr,
  output reg [31:0] din,
  output reg valid,
  input [31:0] dout
);
  
  begin
    #10;
    en = 0;
    #10;
    en = 1;
    wr_rd = 0;
    addr = 5'b00011;
    valid = 1;
    din = 32'h3A3A3A3A;
    #10;
    if (dout !== 32'h3A3A3A3A) $display("Test case single_wr_rd failed");
  end
endtask
