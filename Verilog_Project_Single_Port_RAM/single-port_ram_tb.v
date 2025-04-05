module single_port_ram_tb;
  parameter ADDR_WIDTH = 5;
  parameter DATA_WIDTH = 32;
  parameter MEM_DEPTH = 32;
  
  reg                   clk = 0;    // Initialize clock
  reg                   rstn = 1;    // Initialize reset
  reg                   en;
  reg                   wr_rd;
  reg  [ADDR_WIDTH-1:0] addr;
  reg  [DATA_WIDTH-1:0] din;
  reg                   valid;
  wire [DATA_WIDTH-1:0] dout;
  wire                  ready;
  wire                  error;
  
  // Instantiate DUT
  single_port_ram dut (
    .clk(clk),
    .rstn(rstn),
    .en(en),
    .wr_rd(wr_rd),
    .addr(addr),
    .din(din),
    .valid(valid),
    .dout(dout),
    .ready(ready),
    .error(error)
  );
  
  //Test cases
  
  // Clock generation and test case 1: stability_with_changing_clk
  parameter freq = 100; // Frequency in MHz
  parameter clk_period = 1.0 / freq * 1000; // Clock period in ns
  parameter tclk_high = clk_period * 0.5; // Duty cycle
  parameter tclk_low = clk_period - tclk_high;
  
  initial begin
    // Generate clock
    forever begin
      #tclk_low;
      clk = 1;
      #tclk_high;
      clk = 0;
    end
  end
  
  initial begin
    // Reset generation and test case 2: rst_during_wr_rd
    #15 rstn = 0;
    #15 rstn = 1;
    
    // Test case 2: rst_during_wr_rd
    en = 1;
    wr_rd = 1;
    addr = 5'b00010;
    din = 32'h2A2A2A2A;
    valid = 1;
    #10;
    rstn = 0; // Assert reset during write
    #10;
    rstn = 1;
    #10;
    en = 1;
    wr_rd = 0;
    addr = 5'b00010;
    valid = 1;
    #10;
    if (dout !== 32'h2A2A2A2A) $display("Test case 2 failed");
    
    // Test case 3: single_wr_rd
    #10;
    en = 1;
    wr_rd = 1;
    addr = 5'b00011;
    din = 32'h3A3A3A3A;
    valid = 1;
    #10;
    en = 0;
    #10;
    en = 1;
    wr_rd = 0;
    addr = 5'b00011;
    valid = 1;
    #10;
    if (dout !== 32'h3A3A3A3A) $display("Test case 3 failed");
      
    // Test case 4: multiple_wr_rd
    #10;
    en = 1;
    wr_rd = 1;
    addr = 5'b00100;
    din = 32'h4A4A4A4A;
    valid = 1;
    #10;
    addr = 5'b00101;
    din = 32'h4B4B4B4B;
    valid = 1;
    #10;
    en = 0;
    #10;
    en = 1;
    wr_rd = 0;
    addr = 5'b00100;
    valid = 1;
    #10;
    if (dout !== 32'h4A4A4A4A) $display("Test case 4.1 failed");
    addr = 5'b00101;
    valid = 1;
    #10;
    if (dout !== 32'h4B4B4B4B) $display("Test case 4.2 failed");
    
    // Test case 5: random_wr_rd
    #10;
    en = 1;
    wr_rd = 1;
    addr = 5'b00110;
    din = 32'h5A5A5A5A;
    valid = 1;
    #10;
    addr = 5'b00111;
    din = 32'h5B5B5B5B;
    valid = 1;
    #10;
    en = 0;
    #10;
    en = 1;
    wr_rd = 0;
    addr = 5'b00110;
    valid = 1;
    #10;
    if (dout !== 32'h5A5A5A5A) $display("Test case 5.1 failed");
    addr = 5'b00111;
    valid = 1;
    #10;
    if (dout !== 32'h5B5B5B5B) $display("Test case 5.2 failed");
    
    // Test case 6: back_to_back_wr_rd
    #10;
    en = 1;
    wr_rd = 1;
    addr = 5'b01000;
    din = 32'h6A6A6A6A;
    valid = 1;
    #10;
    en = 0;
    #10;
    en = 1;
    wr_rd = 0;
    addr = 5'b01000;
    valid = 1;
    #10;
    if (dout !== 32'h6A6A6A6A) $display("Test case 6.1 failed");
    #10;
    en = 1;
    wr_rd = 1;
    addr = 5'b01000;
    din = 32'h6B6B6B6B;
    valid = 1;
    #10;
    en = 0;
    #10;
    en = 1;
    wr_rd = 0;
    addr = 5'b01000;
    valid = 1;
    #10;
    if (dout !== 32'h6B6B6B6B) $display("Test case 6.2 failed");
    
    // Test case 7: error_handling
    #10;
    en = 1;
    wr_rd = 1;
    addr = 5'b11111;    // Address out of bounds for a 32-depth memory
    din = 32'h7A7A7A7A;
    valid = 1;
    #10;
    if (!error) $display("Test case 7 failed");
    
    // Simulation Time
    #900;
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
