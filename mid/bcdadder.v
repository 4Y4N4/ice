module bcdadder(
                //1digit 4bit bcdadder
 input        cin,
 input [3:0]  num1,
 input [3:0]  num2,
 output [3:0] out,
 output       carry);

   wire        ci;
   wire [3:0]  x1;
   wire [3:0]  x2;
   wire [3:0]  y;
   wire        car;

   wire [3:0] z;
   wire [3:0] z_;

   wire      car0;

   Cla fba1 (.num1(x1), .num2(x2), .out(z), .car(car0), .cin(ci));
   Cla fba2 (.num1(z_), .num2(z), .out(y), .car(), .cin(1'b0));

   //4-bit bcd adder can be represented by two 4-bit full adder

   assign x1[3:0] = num1[3:0];
   assign x2[3:0] = num2[3:0];
   assign ci = cin;
   // i/o assign

   assign car = car0||(z[3]&&z[2])||(z[3]&&z[1]);
   //carry out

   assign z_ = {1'b0, car, car, 1'b0};

   assign out[3:0] =y[3:0];
   assign carry = car;

`ifdef FORMAL
   assert property (num1 > 9 || num2 > 9 || (num1 + num2 + cin) % 10 == out);
   assert property (num1 > 9 || num2 > 9 || (num1 + num2 + cin) / 10 == carry);
`endif
   //don't care condition : input is not bcd
endmodule // bcdadder
