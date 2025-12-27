module tt_um_m_prs_cpu (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [7:0]  ui_in,
    output wire [7:0]  uo_out,
    input  wire [7:0]  uio_in,
    output wire [7:0]  uio_out,
    output wire [7:0]  uio_oe
);

    // required
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    wire reset = ~rst_n;

    // YOUR CPU LOGIC GOES HERE
    // ui_in  = switch_in
    // uo_out = led_out

endmodule
