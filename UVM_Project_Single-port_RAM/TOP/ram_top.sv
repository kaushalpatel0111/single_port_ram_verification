// RAM TOP
`ifndef RAM_TOP
`define RAM_TOP

`include "ram_define.sv"
`include "ram_interface.sv"

module ram_top();
    import uvm_pkg::*;
    import ram_pkg::*;
    `include "uvm_macros.svh"

    bit clk, rstn;

    // Variable to hold the frequency from $plusargs
    real freq = 100.0; // Default frequency in MHz

    // Compute clock period based on frequency
    real clk_period; 
    real tclk_high; 
    real tclk_low;

    // Clock generation
    initial begin
        // Read clock frequency from $plusargs
        if ($value$plusargs("clk_freq=%f", freq)) begin
            $display("Clock frequency set to %f MHz", freq);
        end else begin
            $display("Using default clock frequency %f MHz", freq);
        end

        // Calculate clock period and duty cycle
        clk_period = 1.0 / freq * 1000; // Clock period in ns
        tclk_high = clk_period * 0.5;   // 50% Duty cycle
        tclk_low = clk_period - tclk_high;

        // Generate clock
        forever begin
            #tclk_low;
            clk = 1;
            #tclk_high;
            clk = 0;
        end
    end

    // Reset task: 1
    task init_rst(int delay = 10);
      rstn = 0;
      #delay;
      rstn = 1;      
    endtask

    // Reset task: 2
    task in_bw_rst(int start_rst, end_rst);
        rstn = 1;
        #start_rst;
        rstn = 0;
        #end_rst;
        rstn = 1;
    endtask

    // Reset generation
    initial begin
        // Initiate initial reset from $plusargs
        if ($test$plusargs("init_rst")) begin
            $display("Inside initial reset test");
            init_rst(5);
        end

        // Initiate in between reset from $plusargs
        if ($test$plusargs("in_bw_rst")) begin
            $display("Inside in between reset test");
            in_bw_rst(40, 50);
        end
    end

    ram_interface intf(clk, rstn);

    single_port_ram_rtl DUT (
        .clk(clk),
        .rstn(rstn),
        .en(intf.en),
        .wr_rd(intf.wr_rd),
        .addr(intf.addr),
        .din(intf.din),
        .valid(intf.valid),
        .dout(intf.dout),
        .ready(intf.ready),
        .error(intf.error)
    );
    
    // Test control
    initial begin
        fork
            uvm_config_db #(virtual ram_interface)::set(uvm_root::get(), "*", "vif", intf);
            run_test("ram_base_test");
        join
    end

endmodule

`endif
