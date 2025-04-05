////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : err_handling.sv
//Description	: Test case: Error Handling
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM error handling test case

`ifndef RAM_ERROR_TEST
`define RAM_ERROR_TEST

class error_handling extends generator;
  bit [`ADDR_WIDTH-1:0] que[$];
  
  task main();
    begin
      // Generate write transaction
      trans = new();
      assert(trans.randomize() with {trans.wr_rd == WRITE;});
      trans.din = 'hZA7X7A7Z;
      trans.display("[GENERATOR]: WRITE");
      que.push_back(trans.addr);
      config_db::gen2drv.put(trans);

      // Generate read transaction
      trans = new();
      assert(trans.randomize() with {trans.wr_rd == READ;});
      trans.display("[GENERATOR]: READ");
      trans.addr = que.pop_back();
      config_db::gen2drv.put(trans);
    end
  endtask
endclass

`endif
