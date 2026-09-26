# CF_OSC_RC24M behavioral model

Ideal functional model for digital simulation. It is **not** SPICE-accurate
and it is **not** silicon-verified. Do not add this file to OpenLane
`VERILOG_FILES`.

## Files

| File | Replaces |
|---|---|
| `CF_OSC_RC24M_core.v` | `hdl/gl/CF_OSC_RC24M_core.v` |

Keep the customer wrap in `hdl/gl/CF_OSC_RC24M.v`. Do **not** compile the empty
`hdl/gl/CF_OSC_RC24M_core.v` stub in the same sim (duplicate module name).

```bash
./verify/beh_model/run_tb.sh
```

## Behavior

Ideal main oscillator. `fs[2:0]` selects 3/6/12/24/48/67/80/96 MHz on `iclkout`. `clk_ext_en` routes `clk_ext` to `clkout`. `clk_2x_en` runs `clk2xout` at twice that frequency. `pd` or `reset` stops the clocks.
