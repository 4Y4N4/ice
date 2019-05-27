module logic_design_tb;
   integer i;

   reg [4:0] sw;
   reg       clock;
   wire [6:0] HEX0, HEX1, HEX3;

   logic_design ld(.SW(sw),
                   .CLOCK_50(clock),
                   .HEX0(HEX0),
                   .HEX1(HEX1),
                   .HEX3(HEX3));

   initial begin
      $dumpfile("logic_design_wave.vcd");
      $dumpvars(0, ld);

      clock <= 0;
      sw <= 0;

      #10;
      sw[4] <= 1;
      #10;
      sw <= 0;
      #10;

      for(i = 0; i < 512; i++)
        begin
           clock <= ~clock;

           if(i % 4 == 0)
             begin
                sw <= sw + 1;
             end
           #100;
        end
   end

endmodule // logic_design_tb
