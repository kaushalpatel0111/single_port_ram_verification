// RAM Agent
`ifndef RAM_AGENT
`define RAM_AGENT

class ram_agent extends uvm_agent;

    ram_monitor mon_h;
    ram_driver drv_h; 
    ram_sequencer seqr_h;
    
    `uvm_component_utils(ram_agent)
    
    function new(string name = "ram_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_h = ram_monitor::type_id::create("mon_h", this);
        drv_h = ram_driver::type_id::create("drv_h", this);
        seqr_h = ram_sequencer::type_id::create("seqr_h", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drv_h.seq_item_port.connect(seqr_h.seq_item_export);
    endfunction

endclass

`endif 
