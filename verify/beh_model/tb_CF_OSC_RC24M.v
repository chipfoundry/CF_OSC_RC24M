`timescale 1ns / 1ps

module tb_CF_OSC_RC24M;
    integer errors, nimo, n2x;
    reg reset_nonsrpg, usb_off, reset, clk_ext_en, clk_2x_en, usb_off_dly_in, pd, vpwr, vgnd;
    reg [2:0] fsoffset, fs;
    reg [7:0] offset;
    reg [5:0] gain;
    reg clk_ext_drv;
    wire pb, iout, clkout, clk2xout, iclkout, usb_off_dly_out;
    wire clk_ext = clk_ext_drv;
    wire vref1, iref;

    CF_OSC_RC24M u (
        .reset_nonsrpg(reset_nonsrpg), .pb(pb), .fsoffset(fsoffset), .fs(fs),
        .offset(offset), .usb_off(usb_off), .gain(gain), .iout(iout), .reset(reset),
        .clk_ext_en(clk_ext_en), .clkout(clkout), .clk_ext(clk_ext), .clk_2x_en(clk_2x_en),
        .clk2xout(clk2xout), .iclkout(iclkout), .vref1(vref1), .usb_off_dly_out(usb_off_dly_out),
        .usb_off_dly_in(usb_off_dly_in), .pd(pd), .vpwr(vpwr), .vgnd(vgnd), .iref(iref)
    );

    initial begin
        errors = 0; nimo = 0; n2x = 0;
        reset_nonsrpg = 1; usb_off = 0; reset = 0; clk_ext_en = 0; clk_2x_en = 1;
        usb_off_dly_in = 0; pd = 0; vpwr = 1; vgnd = 0; fsoffset = 0; fs = 3'd3;
        offset = 0; gain = 0; clk_ext_drv = 0;
    end

    always @(posedge iclkout) nimo = nimo + 1;
    always @(posedge clk2xout) n2x = n2x + 1;

    initial begin
        #1000;
        if (nimo < 20 || nimo > 28) begin
            $display("FAIL imo edges %0d", nimo);
            errors = errors + 1;
        end else $display("PASS imo %0d", nimo);
        if (n2x < 40 || n2x > 56) begin
            $display("FAIL 2x edges %0d", n2x);
            errors = errors + 1;
        end else $display("PASS 2x %0d", n2x);
        if (iout !== 1'b1 || pb !== 1'b1) begin
            $display("FAIL bias pins");
            errors = errors + 1;
        end else $display("PASS bias");
        clk_ext_en = 1;
        clk_ext_drv = 1;
        #1;
        if (clkout !== 1'b1) begin
            $display("FAIL ext mux");
            errors = errors + 1;
        end else $display("PASS ext mux");
        clk_ext_en = 0;
        pd = 1;
        #100;
        if (iclkout !== 1'b0 || clk2xout !== 1'b0 || iout !== 1'b0) begin
            $display("FAIL pd");
            errors = errors + 1;
        end else $display("PASS pd");
        if (errors == 0) $display("CF_OSC_RC24M behavioral self-check passed");
        else $display("CF_OSC_RC24M behavioral self-check FAILED %0d", errors);
        $finish(errors != 0);
    end
endmodule
