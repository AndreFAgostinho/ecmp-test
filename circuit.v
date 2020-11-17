`timescale 1ns / 1ps
`include "iob_lib.vh"

module circuit
  (
  `INPUT(rst,1),
  `INPUT(clk,1),
  `INPUT(en,1),
  `INPUT(x,12),
  `OUTPUT(y,32)
  );

  `SIGNAL(acc, 32)
  `SIGNAL(x_abs, 12)

  `COMB begin
    if (x[11] == 1'b1) begin
      x_abs = -x;
    end
    else begin
      x_abs = x;
    end
  end



  `ACC_ARE(clk, rst, 1'b0, en, acc, x_abs)
  `SIGNAL2OUT(y, acc)

endmodule
