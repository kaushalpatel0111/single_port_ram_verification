// RAM Seq_item
`ifndef RAM_SEQ_ITEM
`define RAM_SEQ_ITEM

typedef enum bit {WRITE = 1'b1, READ = 1'b0} ram_operation_t;

class ram_seq_item extends uvm_sequence_item;

    // Randomizable signals
    rand ram_operation_t        wr_rd;   // Enum for write or read operation
    rand logic  [`ADDR_WIDTH-1:0] addr;  // RAM address
    rand logic  [`DATA_WIDTH-1:0] din;   // RAM input data

    // Sampling signals
    bit  [`DATA_WIDTH-1:0] dout;         // RAM output data
    bit                   error;         // Error signal

    `uvm_object_utils_begin(ram_seq_item)
        `uvm_field_enum(ram_operation_t,wr_rd,UVM_ALL_ON)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(din, UVM_ALL_ON)
    `uvm_object_utils_end
    
    function new(string name = "ram_seq_item");
        super.new(name);
    endfunction

endclass                                             

`endif
