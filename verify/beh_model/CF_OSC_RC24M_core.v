`timescale 1ns / 1ps

// Ideal functional model of analog leaf CF_OSC_RC24M_core.
// Drop this file in place of hdl/gl/CF_OSC_RC24M_core.v for simulation.
// Do not add it to OpenLane VERILOG_FILES.
//
// Assumed protocol (ideal, not silicon-verified):
//   * pd or reset high stops the clocks
//   * fs[2:0] selects 3/6/12/24/48/67/80/96 MHz on iclkout
//   * clk_ext_en routes clk_ext onto clkout; otherwise clkout follows iclkout
//   * clk_2x_en gates clk2xout at twice the IMO frequency
// Offset, gain, and USB trim are not modeled. Reference pins are inputs only.

module CF_OSC_RC24M_core (
    reset_nonsrpg,
    pb,
    fsoffset,
    fs,
    offset,
    usb_off,
    gain,
    iout,
    reset,
    clk_ext_en,
    clkout,
    clk_ext,
    clk_2x_en,
    clk2xout,
    iclkout,
    vref1,
    usb_off_dly_out,
    vnb,
    usb_off_dly_in,
    pd,
    vpwr,
    vgnd,
    iref,
    vpb
);
    input reset_nonsrpg;
    output pb;
    input [2:0] fsoffset;
    input [2:0] fs;
    input [7:0] offset;
    input usb_off;
    input [5:0] gain;
    output iout;
    input reset;
    input clk_ext_en;
    output clkout;
    inout clk_ext;
    input clk_2x_en;
    output clk2xout;
    output iclkout;
    inout vref1;
    output usb_off_dly_out;
    inout vnb;
    input usb_off_dly_in;
    input pd;
    inout vpwr;
    inout vgnd;
    inout iref;
    inout vpb;

    localparam real IOUT_A = 9.6e-6;
    localparam real I_PRESENT = 1.0e-9;
    localparam real V_PRESENT = 0.05;

    reg iclkout_r;
    reg clk2xout_r;
    real half_imo_ns;
    real half_2x_ns;
    real iout_a;
    real pb_v;

    wire imo_run = (pd !== 1'b1) && (reset !== 1'b1);
    wire run_2x = imo_run && (clk_2x_en === 1'b1);

    function real half_period_ns;
        input [2:0] sel;
        real mhz;
        begin
            case (sel)
                3'd0: mhz = 3.0;
                3'd1: mhz = 6.0;
                3'd2: mhz = 12.0;
                3'd3: mhz = 24.0;
                3'd4: mhz = 48.0;
                3'd5: mhz = 67.0;
                3'd6: mhz = 80.0;
                default: mhz = 96.0;
            endcase
            half_period_ns = 1.0e3 / (2.0 * mhz);
        end
    endfunction

    initial begin
        iclkout_r = 1'b0;
        clk2xout_r = 1'b0;
    end

    always begin
        if (!imo_run) begin
            iclkout_r = 1'b0;
            @(posedge imo_run);
        end else begin
            half_imo_ns = half_period_ns(fs);
            #(half_imo_ns) iclkout_r = ~iclkout_r;
        end
    end

    always begin
        if (!run_2x) begin
            clk2xout_r = 1'b0;
            @(posedge run_2x);
        end else begin
            half_2x_ns = half_period_ns(fs) / 2.0;
            #(half_2x_ns) clk2xout_r = ~clk2xout_r;
        end
    end

    always @(*) begin
        if (!imo_run) begin
            iout_a = 0.0;
            pb_v = 0.0;
        end else begin
            iout_a = IOUT_A;
            pb_v = 0.8;
        end
    end

    assign iclkout = iclkout_r;
    assign clk2xout = clk2xout_r;
    assign clkout = (clk_ext_en === 1'b1) ? clk_ext : iclkout_r;
    assign iout = (iout_a > I_PRESENT) ? 1'b1 : 1'b0;
    assign pb = (pb_v > V_PRESENT) ? 1'b1 : 1'b0;
    assign usb_off_dly_out = imo_run ? usb_off_dly_in : 1'b0;
endmodule
