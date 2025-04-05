task multiple_wr1(
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
    addr = 5'b00100;
    din = 32'h4A4A4A4A;
    valid = 1;
  end
endtask

task multiple_rd1(
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
    addr = 5'b00100;
    din = 32'h4A4A4A4A;
    valid = 1;
    #10;
    if (dout !== 32'h4A4A4A4A) $display("Test case multiple_wr_rd 4.1 failed");
  end
endtask

task multiple_wr2(
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
    addr = 5'b00101;
    din = 32'h4B4B4B4B;
    valid = 1;
    
  end
endtask

task multiple_rd2(
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
    addr = 5'b00101;
    din = 32'h4B4B4B4B;
    valid = 1;
    #10;
    if (dout !== 32'h4B4B4B4B) $display("Test case multiple_wr_rd 4.2 failed");
  end
endtask
