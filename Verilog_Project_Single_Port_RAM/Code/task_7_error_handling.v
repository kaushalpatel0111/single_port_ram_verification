task error_handling(
  output reg en,
  output reg wr_rd,
  output reg [4:0] addr,
  output reg [31:0] din,
  output reg valid,
  input error
);
    begin
      en = 1;
      wr_rd = 1;
      addr = 5'b11111;    // Address out of bounds for a 32-depth memory
      din = 32'h7A7X7A7A;
      valid = 1;
      #10;
      if (!error) $display("Test case 7 failed");
    end
endtask