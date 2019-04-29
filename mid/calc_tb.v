module calc_tb;
   wire [7:0] out;
   wire       cout;
   wire [7:0] a;
   wire [7:0] b;
   wire       cin;
   wire       operation;
   reg [17:0]  siminput;

   integer    i;

   assign {a, b, cin, operation} = siminput;

   top as(.out(out),
                    .flowIndicator(cout),
                    .num1(a),
                    .num2(b),
                    .sel(operation));

   initial begin
      $dumpfile("calc_wave.vcd");
      $dumpvars(0, as);

      for(i = 0; i < 1024; i++)
        begin
           siminput <= i;
           #500;
        end
   end
endmodule // calc_tb
