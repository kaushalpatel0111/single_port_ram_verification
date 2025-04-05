// Testcase 5: err_test 
`ifndef RAM_ERROR_TEST
`define RAM_ERROR_TEST

class ram_err_test extends ram_base_test;

    `uvm_component_utils(ram_err_test)

    ram_err_seq eseq_h;

    function new(string name = "ram_err_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        eseq_h = ram_err_seq::type_id::create("eseq_h");   
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        eseq_h.randomize with {no_of_trans == 1;};
        eseq_h.start(env_h.agnt_h.seqr_h);
        phase.phase_done.set_drain_time(this, 50);
        phase.drop_objection(this);
    endtask

endclass

`endif
