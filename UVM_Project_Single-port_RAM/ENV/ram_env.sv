// RAM Environment
`ifndef RAM_ENV
`define RAM_ENV

class ram_env extends uvm_env;

    ram_agent agnt_h;
    ram_scoreboard scb_h;
    ram_fc fc_h;
    
    `uvm_component_utils(ram_env)
    
    function new(string name = "ram_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agnt_h = ram_agent::type_id::create("agnt_h", this);
        scb_h = ram_scoreboard::type_id::create("scb_h", this);
        fc_h = ram_fc::type_id::create("fc_h", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agnt_h.mon_h.anlys_port.connect(scb_h.anlys_imp);
        agnt_h.mon_h.anlys_port.connect(fc_h.analysis_export);
    endfunction

endclass

`endif
