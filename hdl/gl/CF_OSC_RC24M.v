// Structural PG wrapper. Analog leaf is CF_OSC_RC24M_core.
// Customer rails are vpwr/vgnd; well taps vpb/vnb/vpbe are tied inside.
module CF_OSC_RC24M (
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
    usb_off_dly_in,
    pd,
    vpwr,
    vgnd,
    iref
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
    input usb_off_dly_in;
    input pd;
    input vpwr;
    input vgnd;
    inout iref;
    CF_OSC_RC24M_core u_core (
        .reset_nonsrpg(reset_nonsrpg),
        .pb(pb),
        .fsoffset(fsoffset),
        .fs(fs),
        .offset(offset),
        .usb_off(usb_off),
        .gain(gain),
        .iout(iout),
        .reset(reset),
        .clk_ext_en(clk_ext_en),
        .clkout(clkout),
        .clk_ext(clk_ext),
        .clk_2x_en(clk_2x_en),
        .clk2xout(clk2xout),
        .iclkout(iclkout),
        .vref1(vref1),
        .usb_off_dly_out(usb_off_dly_out),
        .vnb(vgnd),
        .usb_off_dly_in(usb_off_dly_in),
        .pd(pd),
        .vpwr(vpwr),
        .vgnd(vgnd),
        .iref(iref),
        .vpb(vpwr)
    );
endmodule
