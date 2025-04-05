// RAM Driver
`ifndef RAM_DRIVER
`define RAM_DRIVER

class ram_driver extends uvm_driver #(ram_seq_item);
    
    virtual ram_interface vif;

    `uvm_component_utils(ram_driver)
    
    function new(string name = "ram_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual ram_interface)::get(this, "", "vif", vif))
            `uvm_error("RAM_DRIVER", "Failed to get vif from config_db!");
    endfunction

    task run_phase(uvm_phase phase);
        wait(vif.DRV.rstn);
        forever begin
            seq_item_port.get_next_item(req);
            drive();
            seq_item_port.item_done();
        end  
    endtask

    task drive();
        if(req.wr_rd == WRITE) begin
            vif.DRV.drv_cb.en     <= 1'b1;
            vif.DRV.drv_cb.wr_rd  <= req.wr_rd;
            vif.DRV.drv_cb.addr   <= req.addr;
            vif.DRV.drv_cb.din    <= req.din;
            vif.DRV.drv_cb.valid  <= 1'b1;
        end

        else begin
            vif.DRV.drv_cb.en     <= 1'b1;
            vif.DRV.drv_cb.addr   <= req.addr;
            vif.DRV.drv_cb.wr_rd  <= req.wr_rd;
            vif.DRV.drv_cb.valid  <= 1'b1; 
        end
        
        @(posedge vif.DRV.clk);
    endtask

endclass

`endif
