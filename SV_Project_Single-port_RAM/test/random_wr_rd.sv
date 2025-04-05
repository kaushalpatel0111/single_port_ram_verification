////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : random_wr_rd.sv
//Description	: Test case: Random Write & Read
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM random_wr_rd test case

`ifndef RAM_RANDOM_WR_RD_TEST
`define RAM_RANDOM_WR_RD_TEST

class random_wr_rd extends generator;
  bit  [`ADDR_WIDTH-1:0] que[$];

  task main();
    repeat(10)begin
      // Generate write transaction
      trans = new();
      assert(trans.randomize() with {trans.wr_rd == WRITE;});
      trans.display("[GENERATOR]: WRITE");
      que.push_back(trans.addr);
      config_db::gen2drv.put(trans);

      trans = new();
      assert(trans.randomize() with {trans.wr_rd == READ;});
      trans.display("[GENERATOR]: READ");
      trans.addr = que.pop_back();
      config_db::gen2drv.put(trans);
    end
  endtask
endclass

`endif
