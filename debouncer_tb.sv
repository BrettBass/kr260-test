module debouncer_tb;
  timeunit 1ns/100ps;
  logic clk;
  logic rst_n;
  logic btn;            // Button input signal
  logic btn_pls_out;    // Single pulse when button press is stable


    debouncer #(.DEBOUNCE_WAIT(8)) utt (
        clk,
        rst_n,
        btn,
        btn_pls_out
    );


    always #5ns clk = ~clk;

    initial begin
        rst_n = 0;
        clk = 0;
        #10ns
        rst_n = 1;

        // FIRST CASE
        btn = 1;
        repeat (9) @(posedge clk);
        assert(btn_pls_out == 1) else $display("CASE 1: Expected btn debounce 1, received 0");

        #40ns
        // SECOND CASE
        btn = 0;
        repeat (10) @(posedge clk);
        assert(btn_pls_out == 0) else $display("CASE 2: Expected btn debounce 0, received 1");

        // THIRD CASE
        btn = 1;
        repeat (4) @(posedge clk);
        btn = 0;
        repeat (4) @(posedge clk);
        assert(btn_pls_out == 0) else $display("CASE 3: Expected btn debounce 0, received 1");

        #20ns $finish;

    end

    initial begin
        $timeformat(-9, 1, " ns", 6);
    end

    initial $display("  TIME\t\t CLK\t RST_N\t BTN\t BTN_PLS_OUT\t");
    initial $monitor("  %t\t %b\t %b\t %b\t %b\t",$realtime, clk, rst_n, btn, btn_pls_out);

endmodule
