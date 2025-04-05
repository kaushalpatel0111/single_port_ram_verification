////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : single_wr_rd.sv
//Description	: Test case: Single Write & Read
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM single_wr_rd test case

`ifndef RAM_SINGLE_WR_RD_TEST
`define RAM_SINGLE_WR_RD_TEST

class single_wr_rd extends generator;
  bit  [`ADDR_WIDTH-1:0] que[$];

  task main();
    begin
      // Generate write transaction
      trans = new();
      assert(trans.randomize() with {trans.wr_rd == WRITE;});
      trans.display("[GENERATOR]: WRITE");
      que.push_back(trans.addr);
      config_db::gen2drv.put(trans);

      #10;
      
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
