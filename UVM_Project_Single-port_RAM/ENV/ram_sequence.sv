// RAM Sequence
`ifndef RAM_SEQ
`define RAM_SEQ

class ram_base_seq extends uvm_sequence #(ram_seq_item);

    int addr_temp;
    rand int no_of_trans;
    
    `uvm_object_utils(ram_base_seq)
    
    function new(string name = "ram_base_seq");
        super.new(name);
    endfunction
    
    task body();
        repeat(no_of_trans) begin
            req = ram_seq_item::type_id::create("req");
            
            start_item(req);
            assert(req.randomize with {wr_rd==1;});
            addr_temp = req.addr;
            finish_item(req);
            
            req = ram_seq_item::type_id::create("req");
            
            start_item(req);
            assert(req.randomize with {wr_rd==0; addr == addr_temp;});
            finish_item(req);
        end
    endtask
endclass

class ram_err_seq extends ram_base_seq;

    int addr_temp;
    rand int no_of_trans;
 
    `uvm_object_utils(ram_err_seq)
    
    function new(string name = "ram_err_seq");
        super.new(name);
    endfunction
    
    task body();
        repeat(no_of_trans) begin
            req = ram_seq_item::type_id::create("req");
            start_item(req);
            assert(req.randomize with {wr_rd==1;});
            addr_temp = req.addr;
            req.din = 'hZA7X7A7Z;
            finish_item(req);
            
            req = ram_seq_item::type_id::create("req");
            start_item(req);
            assert(req.randomize with {wr_rd==0; addr == addr_temp;});
            finish_item(req);
        end
    endtask

endclass

`endif
