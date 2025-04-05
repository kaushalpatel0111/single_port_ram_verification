// Testcase 6: in_bw_rst
`ifndef RAM_IN_BW_RST_TEST
`define RAM_IN_BW_RST_TEST

class ram_in_bw_rst extends ram_base_test;

    `uvm_component_utils(ram_in_bw_rst)

    ram_base_seq seq_h;

    function new(string name = "ram_in_bw_rst", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        seq_h = ram_base_seq::type_id::create("seq_h");   
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq_h.randomize with {no_of_trans == 31;};
        seq_h.start(env_h.agnt_h.seqr_h);
        phase.phase_done.set_drain_time(this, 150); 
        phase.drop_objection(this);
    endtask

endclass

`endif
