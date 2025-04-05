// RAM Base Test 
`ifndef RAM_BASE_TEST
`define RAM_BASE_TEST

class ram_base_test extends uvm_test;
    
    `uvm_component_utils(ram_base_test)

    ram_env env_h;

    function new(string name = "ram_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env_h = ram_env::type_id::create("env_h", this);   
    endfunction

endclass

`endif
