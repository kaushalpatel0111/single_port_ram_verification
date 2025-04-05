////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : environment.sv
//Description	: Environment class
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM environment class

`ifndef RAM_ENVIRONMENT
`define RAM_ENVIRONMENT

// Define the environment class
class environment;
 
  // Component instances
  agent      ag;
  scoreboard sb;

  // Constructor
  function new();
    // Instantiate the agent & scoreboard
    ag = new();
    sb = new();
  endfunction

  // Task to start all components
  task run();
    fork
      ag.gen.main();
      ag.drv.main();
      ag.mon.main();
      sb.main();
  join_any
  endtask

endclass

`endif
