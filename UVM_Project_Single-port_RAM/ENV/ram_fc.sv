// RAM Functional Coverage
`ifndef RAM_FC
`define RAM_FC

class ram_fc extends uvm_subscriber #(ram_seq_item);
    
    ram_seq_item item;
    real cov;

    `uvm_component_utils(ram_fc)

    covergroup ram_cvg;
        WR_RD: coverpoint item.wr_rd {
            bins wr_rd_c[] = {0,1};
           }
        ADDR: coverpoint item.addr {
            bins addr_c[] = {0,32};
            }
        ERROR: coverpoint item.error {
            bins error_c[] = {0,1};
            }
    endgroup

    function new(string name = "ram_fc", uvm_component parent);
        super.new(name, parent);
        ram_cvg = new();
    endfunction


    function void write(ram_seq_item t);
        item = new t;
        ram_cvg.sample();
    endfunction

    function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
        cov = ram_cvg.get_coverage();
    endfunction

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(), $sformatf("COVERAGE: %0f", cov), UVM_LOW);
    endfunction

endclass

`endif
