////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : coverage.sv
//Description	: Functional Coverage
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM coverage class

`ifndef RAM_FC
`define RAM_FC

class coverage;
    transaction trans;

    covergroup cvg;
        A: coverpoint trans.wr_rd iff (trans.rstn);
        B: coverpoint trans.addr iff (trans.rstn);
        C: coverpoint trans.error iff (trans.rstn);
    endgroup

    function new();
        cvg = new();
    endfunction

    task run(transaction t);
        trans = new t;
         trans.display("COVERAGE");
        cvg.sample();
    endtask
endclass

`endif
