`default_nettype none

module tt_um_simplepiano (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // two instances of tone_gen set to output on two different output ports
  // uo_out[0] and uo_out[1] respectively 
  tone_gen #(
      .MAX_COUNT(42),
      .WIDTH_COUNTER(10)
  ) tone_gen1 (
      .clk (clk),
      .rst (~rst_n),
      .tone(uo_out[0])
  );

  tone_gen #(
      .MAX_COUNT(42),
      .WIDTH_COUNTER(10)
  ) tone_gen2 (
      .clk (clk),
      .rst (~rst_n),
      .tone(uo_out[1])
  );

  // drive the unused signals so that the synthesis tool stops complaining
  assign uo_out[7:2] = 6'b0000_00;


  // set the bidir signals to output mode and drive all of them with 0 for now
  assign uio_oe = 8'b1111_1111;
  assign uio_out = 8'b0000_0000;

endmodule
