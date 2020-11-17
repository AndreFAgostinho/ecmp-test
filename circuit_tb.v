`timescale 1ns / 1ps
`include "iob_lib.vh"

// x is random numbers in the range [-2048,2047] (12 bits)
// passed through y(n) = y(n-1) + |x(n)| should yield in average y = 1024*n

module circuit_tb;

   `CLOCK(clk, 10)
   `RESET(rst, 1, 10)
   `SIGNAL(en, 1)
   `SIGNAL_SIGNED(x, 12)
   `SIGNAL_SIGNED(y_sgn, 32)
   `SIGNAL_OUT(y, 32)

   integer i;

   initial begin
      $dumpfile("circuit.vcd");
      $dumpvars();
      en=0;
      for (i=0; i<101; i=i+1) begin
         @(posedge clk) #1 x= $random % 2048; y_sgn = y;$display("n = %d |x: %d |y = %d",i, x, y_sgn); en=1;
         @(posedge clk) #1 en=0;
      end

      @(posedge clk) #100 $finish;

   end

   circuit c0
     (
      .rst(rst),
      .clk(clk),
      .en(en),
      .x(x),
      .y(y)
      );


endmodule
