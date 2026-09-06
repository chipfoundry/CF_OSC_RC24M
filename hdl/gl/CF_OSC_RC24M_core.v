// Empty blackbox stub for hierarchical integration LVS.
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
endmodule
