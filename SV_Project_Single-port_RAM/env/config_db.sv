`ifndef RAM_CONFIG
`define RAM_CONFIG

class config_db;
    static virtual intf vif;
    static mailbox #(transaction) gen2drv = new();
    static mailbox #(transaction) mon2sb = new();
endclass

`endif
