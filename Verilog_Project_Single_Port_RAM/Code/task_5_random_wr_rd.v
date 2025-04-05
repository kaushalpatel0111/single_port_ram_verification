task random_wr1(
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
    addr = 5'b00110;
    din = 32'h5A5A5A5A;
    valid = 1;
  end
  
endtask

task random_wr2(
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
    addr = 5'b00111;
    din = 32'h5B5B5B5B;
    valid = 1;
  end
  
endtask

task random_rd1(
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
    addr = 5'b00110;
    din = 32'h5A5A5A5A;
    valid = 1;
    #10;
    if (dout !== 32'h5A5A5A5A) $display("Test case random_wr_rd 5.1 failed");
  end
  
endtask
    
task random_rd2(
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
    addr = 5'b00111;
    din = 32'h5B5B5B5B;
    valid = 1;
    #10;
    if (dout !== 32'h5B5B5B5B) $display("Test case random_wr_rd 5.2 failed");
  end
  
endtask
