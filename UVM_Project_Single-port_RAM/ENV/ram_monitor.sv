// RAM Monitor
`ifndef RAM_MONITOR
`define RAM_MONITOR

class ram_monitor extends uvm_monitor;

    virtual ram_interface vif;

    uvm_analysis_port #(ram_seq_item) anlys_port;

    ram_seq_item item;
    
    `uvm_component_utils(ram_monitor)
    
    function new(string name = "ram_monitor", uvm_component parent = null);
        super.new(name, parent);
        item = new();
        anlys_port = new("anlys_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual ram_interface)::get(this, "", "vif", vif))
            `uvm_error("RAM_MONITOR", "Failed to get vif from config_db!");
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.MON.clk);
            monitor();
            anlys_port.write(item);
        end
    endtask

    task monitor();
        item.wr_rd  = ram_operation_t'(vif.MON.mon_cb.wr_rd);
        item.addr   = vif.MON.mon_cb.addr;
        item.din    = vif.MON.mon_cb.din;
        item.dout   = vif.MON.mon_cb.dout;
        item.error  = vif.MON.mon_cb.error;
    endtask

endclass

`endif
