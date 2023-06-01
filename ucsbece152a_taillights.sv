/*
* Copyright (c) 2023, University of California; Santa Barbara
* Distribution prohibited. All rights reserved.
*
* File: ucsbece152a_taillights.sv
* Description: Starter code for taillights.
*/
module ucsbece152a_taillights (
   input logic clk,
   input logic rst_n,
   input logic clk_dimmer_i,

   input logic left_i,
   input logic right_i,
   input logic hazard_i,
   input logic brake_i,
   input logic runlights_i,

   output logic [5:0] lights_o
);
logic [5:0] fsm_pattern;

ucsbece152a_fsm fsm (
.clk(clk),
.rst_n(rst_n),
.left_i(left_i),
.right_i(right_i),
.hazard_i(hazard_i),
.state_o(/* unused */ ),
.pattern_o(fsm_pattern)
);
logic [5:0] lights_runlightsoff, lights_runlightson;
always_comb begin
  lights_runlightsoff = fsm_pattern;
  lights_runlightson= 6'b111_111;
  if(brake_i) begin
    if(left_i & !right_i & !hazard_i)
      lights_runlightsoff[2:0] = 3'b111;
    else if(!left_i & right_i & !hazard_i)
      lights_runlightsoff[5:3] = 3'b111;
    else
      lights_runlightsoff = 6'b111_111;
  end
  lights_o = lights_runlightsoff;
  if(runlights_i && clk_dimmer_i)
    lights_o = lights_runlightson;
end
// TODO: Convert `fsm_pattern` into `lights_o`
endmodule
