////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : monitor.sv
//Description	: Monitor class
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM monitor class

`ifndef RAM_MONITOR
`define RAM_MONITOR

class monitor;
  transaction trans;
  coverage cov;

  function new();
      trans = new();
      cov = new();
  endfunction

  task main();
    forever @(`MON_INF) begin
      if(config_db::vif.rstn) begin
          // Sampling signals from the virtual interface
          trans.wr_rd  = ram_operation_t'(`MON_INF.wr_rd);
          trans.addr   =`MON_INF.addr;
          trans.din    =`MON_INF.din;
          trans.dout   =`MON_INF.dout;
          trans.error  =`MON_INF.error;
          trans.rstn   =config_db::vif.rstn;
          trans.display("MONITOR");
          cov.run(trans);

          // Send the sampled transaction to the scoreboard
          config_db::mon2sb.put(trans);
      end
    end
  endtask
endclass

`endif
