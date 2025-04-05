// RAM Sequencer
`ifndef RAM_SEQR
`define RAM_SEQR

class ram_sequencer extends uvm_sequencer #(ram_seq_item);
    
    `uvm_component_utils(ram_sequencer)

    function new(string name = "ram_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass

`endif
