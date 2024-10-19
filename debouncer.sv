module debouncer
#(
    // Number of clock cycles for stable detection
    parameter integer DEBOUNCE_WAIT = 2_500_000
)
(
    input logic clk,
    input logic rst_n,
    input logic btn,            // Button input signal
    output logic btn_pls_out    // Single pulse when button press is stable
);

// ----------------------------------------------------------------------------
// Local parameters
// ----------------------------------------------------------------------------
    // use $clog2 to calculate the size of the bit vector
    localparam int BIT_SIZE = $clog2(DEBOUNCE_WAIT + 1);


// ----------------------------------------------------------------------------
// Local Variables
// ----------------------------------------------------------------------------
    // signal declaration
    logic btn_r;
    logic btn_f;
    logic [BIT_SIZE-1:0] counter;
    logic is_running;
    logic btn_debounced;

// ----------------------------------------------------------------------------
// External modules instantiation
// ----------------------------------------------------------------------------
    edge_detect btn_in_edge (
        .clk(clk),
        .rst_n(rst_n),
        .sig(btn),
        .r_edge(btn_r),
        .f_edge(btn_f)
        );
    edge_detect dbounce_out_edge (
        .clk(clk),
        .rst_n(rst_n),
        .sig(btn_debounced),
        .r_edge(btn_pls_out), // Rising edge of the button press
        .f_edge(/* Not used */)
        );

// ----------------------------------------------------------------------------
// Debouncer (Counter and stability check)
// ----------------------------------------------------------------------------

always_ff @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        counter <= 'd0;
        btn_debounced <= 'b0;
        is_running <= 'b0;
    end else begin

        if(btn_r == 'b1) begin
            counter <= 'd0;
            is_running <= 'b1;
        end else if (btn_f == 'b1) begin
            counter <= 'd0;
            is_running <= 'b0;
        end else begin
            if(is_running) begin
                if(counter < DEBOUNCE_WAIT) begin
                    counter       <= counter + 1;
                    btn_debounced <= 'b0;
                end else begin
                    btn_debounced <= 'b1;
                    is_running    <= 'b0;
                end
            end
        end
    end
end

endmodule
