////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : driver.sv
//Description	: Driver class
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM driver class

`ifndef RAM_DRIVER
`define RAM_DRIVER

class driver;
  transaction trans;

  task drive();
    forever begin
      config_db::gen2drv.get(trans);
      if(trans.wr_rd == WRITE) begin
      // Drive the transaction onto the virtual interface
      `DRV_INF.en     <= 1'b1;
      `DRV_INF.wr_rd  <= trans.wr_rd;
      `DRV_INF.addr   <= trans.addr;
      `DRV_INF.din    <= trans.din;
      `DRV_INF.valid  <= 1'b1;
  end
  else begin
      `DRV_INF.en     <= 1'b1;
      `DRV_INF.addr   <= trans.addr;
      `DRV_INF.wr_rd  <= trans.wr_rd;
      `DRV_INF.valid  <= 1'b1;
  end
      @(`DRV_INF);
      trans.display("DRIVER");
    end
  endtask

  task reset(); 
      `DRV_INF.en     <= 1'b0;
      `DRV_INF.wr_rd  <= 1'b0;
      `DRV_INF.addr   <= 'b0;
      `DRV_INF.din    <= 'b0;
      `DRV_INF.valid  <= 1'b0;
      wait(config_db::vif.rstn==1'b1);
  endtask

  task main();
    reset();
    forever begin
        fork
            drive();
            @(negedge config_db::vif.rstn);
        join_any
        disable fork;
        reset();
    end
  endtask
endclass

`endif
