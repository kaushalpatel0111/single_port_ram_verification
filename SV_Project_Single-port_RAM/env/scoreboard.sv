////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : scoreboard.sv
//Description	: Scoreboard class
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM scoreboard class

`ifndef RAM_SCOREBOARD
`define RAM_SCOREBOARD

class scoreboard;

  // Memory array to track expected values
  bit [`DATA_WIDTH-1:0] mem_expected [`MEM_DEPTH-1:0];

  // Task to run the scoreboard
  task main();
    transaction trans;

    // Initialize expected memory array
    foreach (mem_expected[i]) begin
      mem_expected[i] = '0;
    end

    // Process transactions
    forever begin
      // Get a transaction from the mailbox
      config_db::mon2sb.get(trans);
      
      // Display the transaction for debugging
      trans.display("SCOREBOARD");

      // Handle transactions based on the operation type
      case (trans.wr_rd)
        WRITE: begin
          mem_expected[trans.addr] = trans.din;
        end
        
        READ: begin
          if (trans.dout !== mem_expected[trans.addr]) begin
              $display("Mismatch at address %0d: Expected %0d, Got %0d", trans.addr, mem_expected[trans.addr], trans.dout);
          end
          else begin
              $display("Match at address %0d: Expected %0d, Got %0d", trans.addr, mem_expected[trans.addr], trans.dout);
          end
        end  
      endcase
    end
  endtask

endclass

`endif
