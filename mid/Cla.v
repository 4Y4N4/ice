module Cla(
           //4 bit Carry look ahead full adder
           input        cin,
           input [3:0]  num1,
           input [3:0]  num2,
           output [3:0] out,
           output       car);
   wire [3:0] x1;
   wire [3:0] x2;
   wire [3:0] y;
   wire       c;
   wire       ci;//C0

   wire [2:0] wc; // xc[i] = C(i-1)
   wire [3:0] p; //pi = ai xor bi
   wire [3:0] g; //gi = ai and bi

   assign c = g[3]||(p[3]&&wc[2]); // Ci = g(i-1) or (p(i-1) and C(i-1))
   assign y = {p[3]^wc[2], p[2]^wc[1], p[1]^wc[0], p[0]^ci};
   //Si = pi xor c[i]

   assign p = {x1[3]^x2[3], x1[2]^x2[2], x1[1]^x2[1], x1[0]^x2[0]};
   assign g = {x1[3]&&x2[3], x1[2]&&x2[2], x1[1]&&x2[1], x1[0]&&x2[0]};

   assign wc[0] = g[0]||(p[0]&&ci);//C1
   assign wc[1] = g[1]||(p[1]&&wc[0]);//C2
   assign wc[2] = g[2]||(p[2]&&wc[1]);//C3

   assign x1[3:0] = num1[3:0];  //assign i/o
   assign x2[3:0] = num2[3:0];
   assign out[3:0] = y[3:0];
   assign car = c;
   assign ci = cin;

`ifdef FORMAL
   assert property ( cin + num1 + num2 == {car, out});
`endif


endmodule // fadder
