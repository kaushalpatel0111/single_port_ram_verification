////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Project	    : Single-port RAM Verification
//File name	    : test.sv
//Description	: Test class
//Created by	: Kaushal Patel
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//RAM test class

`ifndef RAM_TEST
`define RAM_TEST

// Test class definition
class test;

  // Environment instance
  environment env;

  // Test case instance
  back_to_back_wr_rd b2b_wr_rd;
  error_handling error_test;
  single_wr_rd sing_wr_rd;
  multiple_wr_rd multi_wr_rd;
  random_wr_rd rand_wr_rd;

  // Constructor
  function new();
    // Instantiate the environment with the provided virtual interface
    env = new();
  endfunction

  // Task to run the test
  task run();
    // Run the environment
    // Test case:Back to Back Write & Read
    if($test$plusargs("b2b_wr_rd"))begin
        $display("Inside the b2b_wr_rd test case:");
        b2b_wr_rd = new();
        env.ag.gen = b2b_wr_rd;
    end
    // Test case: Error Handling
    if($test$plusargs("error_test"))begin
        $display("Inside the error_handling test case:");
        error_test = new();
        env.ag.gen = error_test;
    end
    // Test case: Single Write & Read
    if($test$plusargs("single_wr_rd"))begin
        $display("Inside the single_wr_rd test case:");
        sing_wr_rd = new();
        env.ag.gen = sing_wr_rd;
    end
    // Test case: Multiple Write & Read
    if($test$plusargs("multi_wr_rd"))begin
        $display("Inside the multiple_wr_rd test case:");
        multi_wr_rd = new();
        env.ag.gen = multi_wr_rd;
    end
    // Test case: Random Write & Read
    if($test$plusargs("rand_wr_rd"))begin
        $display("Inside the rand_wr_rd test case:");
        rand_wr_rd = new();
        env.ag.gen = rand_wr_rd;
    end
    env.run();
  endtask

endclass

`endif
