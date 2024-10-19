module edge_detect
(
    input logic clk,
    input logic rst_n,
    input logic sig,
    output logic r_edge,
    output logic f_edge
    );

// signal declaration
logic delay_reg0;

// delay register
always_ff @(posedge clk, negedge rst_n) begin
    if(~rst_n) begin
        delay_reg0 <= 1'b0;
        r_edge <= 1'b0;
        f_edge <= 1'b0;
    end else begin
        delay_reg0 <= sig;
        r_edge <= ~delay_reg0 & sig;
        f_edge <= delay_reg0 & ~sig;
    end
end

endmodule
