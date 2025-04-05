task back_to_back_wr1(
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
    addr = 5'b01000;
    din = 32'h6A6A6A6A;
    valid = 1;
  end
  
endtask

task back_to_back_wr2(
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
    addr = 5'b01000;
    din = 32'h6B6B6B6B;
    valid = 1;
    
  end
  
endtask

task back_to_back_rd1(
  output reg en,
  output reg wr_rd,
  output reg [4:0] addr,
  output reg [31:0] din,
  output reg valid,
  input [31:0] dout
);
  
  begin
    en = 0;
    #10;
    en = 1;
    wr_rd = 0;
    addr = 5'b01000;
    valid = 1;
    #20;
    if (dout !== 32'h6A6A6A6A) $display("Test case back_to_back_wr_rd 6.1 failed");
  end
  
endtask
  
task back_to_back_rd2(
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
    addr = 5'b01000;
    valid = 1;
    #10;
    if (dout !== 32'h6B6B6B6B) $display("Test case back_to_back_wr_rd 6.2 failed");
  end
  
endtask
