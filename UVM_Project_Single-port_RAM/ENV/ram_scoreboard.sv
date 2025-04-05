// RAM Scoreboard
`ifndef RAM_SCOREBOARD
`define RAM_SCOREBOARD

class ram_scoreboard extends uvm_scoreboard;
    ram_seq_item item_q[$];

    // Memory array to track expected values
    bit [`DATA_WIDTH-1:0] mem_expected [`MEM_DEPTH-1:0];
    
    uvm_analysis_imp #(ram_seq_item, ram_scoreboard) anlys_imp;

    `uvm_component_utils(ram_scoreboard)

    function new(string name = "ram_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        anlys_imp = new("anlys_imp", this);

        foreach (mem_expected[i]) begin
            mem_expected[i] = '0;
        end
    endfunction

    function void write(ram_seq_item item);
        item_q.push_back(item);
    endfunction

    task run_phase(uvm_phase phase);
        ram_seq_item item;

        forever begin
            wait(item_q.size() > 0);
            item = item_q.pop_front();
            
            case (item.wr_rd)
                WRITE: begin
                    mem_expected[item.addr] = item.din;
                end
                
                READ: begin
                    if (item.dout !== mem_expected[item.addr]) begin
                        `uvm_info(get_type_name(), $sformatf("Mismatch at address %0d: Expected %0d, Got %0d", item.addr, mem_expected[item.addr], item.dout), UVM_LOW)
                    end
                    else begin
                        `uvm_info(get_type_name(), $sformatf("Match at address %0d: Expected %0d, Got %0d", item.addr, mem_expected[item.addr], item.dout), UVM_LOW)
                    end
                end
            endcase
        end
    endtask

endclass

`endif
