// SPDX-License-Identifier: Apache-2.0
// TinyTapeout scan wrapper — DO NOT MODIFY

module scan_wrapper (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [7:0]  ui_in,
    output wire [7:0]  uo_out,

    input  wire [7:0]  uio_in,
    output wire [7:0]  uio_out,
    output wire [7:0]  uio_oe
);

    // Instantiate user module
    tt_um_m_prs_cpu user_module (
        .clk     (clk),
        .rst_n   (rst_n),
        .ui_in   (ui_in),
        .uo_out  (uo_out),
        .uio_in  (uio_in),
        .uio_out (uio_out),
        .uio_oe  (uio_oe)
    );

endmodule
