`include "rst_during_wr_rd.sv"
//`include "single_wr_rd.sv"
//`include "multiple_wr_rd.sv"
//`include "random_wr_rd.sv"
//`include "back_to_back_wr_rd.sv"
//`include "error_handling.sv"

module single_port_ram_tb;
  parameter ADDR_WIDTH = 5;
  parameter DATA_WIDTH = 32;
  parameter MEM_DEPTH = 32;

  reg                   clk = 0;    // Initialize clock
  reg                   rstn = 1;   // Initialize reset
  reg                   en;
  reg                   wr_rd;
  reg  [ADDR_WIDTH-1:0] addr;
  reg  [DATA_WIDTH-1:0] din;
  reg                   valid;
  wire [DATA_WIDTH-1:0] dout;
  wire                  ready;
  wire                  error;

  // Variable to hold the frequency from $plusargs
  real freq = 100.0; // Default frequency in MHz
  
  // Compute clock period based on frequency
  real clk_period; 
  real tclk_high; 
  real tclk_low;

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

  // Clock generation
  initial begin
    // Read clock frequency from $plusargs
    if ($value$plusargs("clk_freq=%f", freq)) begin
      $display("Clock frequency set to %f MHz", freq);
    end else begin
      $display("Using default clock frequency %f MHz", freq);
    end

    // Task 1: stability_with_changing_clk
    clk_period = 1.0 / freq * 1000; // Clock period in ns
    tclk_high = clk_period * 0.5;   // 50% Duty cycle
    tclk_low = clk_period - tclk_high;

    // Generate clock
    forever begin
      #tclk_low;
      clk = 1;
      #tclk_high;
      clk = 0;
    end
  end

  // Task invocations based on $plusargs
  initial begin
    if ($test$plusargs("run_rst_during_wr_rd")) begin
      rst_during_wr(en, wr_rd, addr, din, valid, rstn, dout);
      rst_during_rd(en, wr_rd, addr, din, valid, rstn, dout);
    end
    
    if ($test$plusargs("run_single_wr_rd")) begin
      single_wr(en, wr_rd, addr, din, valid, dout);
      single_rd(en, wr_rd, addr, din, valid, dout);
    end
 
    if ($test$plusargs("run_multiple_wr_rd")) begin
      multiple_wr1(en, wr_rd, addr, din, valid, dout);
      multiple_wr2(en, wr_rd, addr, din, valid, dout);
      multiple_rd1(en, wr_rd, addr, din, valid, dout);
      multiple_rd2(en, wr_rd, addr, din, valid, dout);
    end
    
    if ($test$plusargs("run_random_wr_rd")) begin
      random_wr1(en, wr_rd, addr, din, valid, dout);
      random_rd1(en, wr_rd, addr, din, valid, dout);
      random_wr2(en, wr_rd, addr, din, valid, dout);
      random_rd2(en, wr_rd, addr, din, valid, dout);
    end
    
    if ($test$plusargs("run_back_to_back_wr_rd")) begin
      back_to_back_wr1(en, wr_rd, addr, din, valid, dout);
      back_to_back_wr2(en, wr_rd, addr, din, valid, dout);
      back_to_back_rd1(en, wr_rd, addr, din, valid, dout);
      back_to_back_rd2(en, wr_rd, addr, din, valid, dout);
    end
    
    if ($test$plusargs("run_error_handling")) begin
      error_handling(en, wr_rd, addr, din, valid, error);
    end

    // Simulation time
    #1000;
    $finish;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule

// EDA Run Options command example: vcs -full64 -sverilog single_port_ram.sv single_port_ram_tb.sv && ./simv +clk_freq=250 +run_rst_during_wr_rd