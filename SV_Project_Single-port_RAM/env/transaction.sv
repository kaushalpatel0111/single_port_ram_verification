////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : transaction.sv
//Description	: Transaction class
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM transaction class

`ifndef RAM_TRANSACTION
`define RAM_TRANSACTION

// Enum for RAM operation type (READ = 1'b0, WRITE = 1'b1)
typedef enum bit {WRITE = 1'b1, READ = 1'b0} ram_operation_t;

class transaction;
  bit rstn;
  // Randomizable signals
  rand ram_operation_t        wr_rd;   // Enum for write or read operation
  rand logic  [`ADDR_WIDTH-1:0] addr;  // RAM address
  rand logic  [`DATA_WIDTH-1:0] din;   // RAM input data

  // Sampling signals
  bit  [`DATA_WIDTH-1:0] dout;         // RAM output data
  bit                   error;         // Error signal

   // Task to display transaction details
  function void display(string block);
      $display("------------------- %0s CLASS -------------------", block);
      $display("Time\t|\tName\t\t|\tValue");
      $display("-------------------------------------------------------");
      $display("%0t\t|\twr_rd\t\t|\t%0d", $time, bit'(wr_rd));
      $display("%0t\t|\taddr\t\t|\t%0d", $time, addr);
      $display("%0t\t|\tdin\t\t|\t%0d", $time, din);
      $display("%0t\t|\tdout\t\t|\t%0d", $time, dout);
      $display("%0t\t|\terror\t\t|\t%0d", $time, error);
      $display("-------------------------------------------------------");
  endfunction

endclass

`endif
