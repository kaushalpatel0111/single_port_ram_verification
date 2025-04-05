////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : agent.sv
//Description	: Agent class
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM agent class

`ifndef RAM_AGENT
`define RAM_AGENT

class agent; 
  // Component instances
  generator gen;
  driver drv;
  monitor mon;

  // Constructor
  function new();
    drv = new();
    drv = new();
    mon = new();
  endfunction
endclass

`endif
