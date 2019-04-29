module tdigadder(
                 //2 digit bcd adder
                 input [7:0]  num1,
                 input [7:0]  num2,
                 output [7:0] out,
                 output       of
                 );

   wire [3:0]           x22;
   wire [3:0]           x21; //slash input to 4bit slice
   wire [3:0]           x12;
   wire [3:0]           x11;
   wire [3:0]           y2;
   wire [3:0]           y1;
   wire                 c0;
   wire                 c1;
   wire                 cout;

   bcdadder bad1(.num1(x21), .num2(x11), .out(y1), .cin(c0), .carry(c1));
   bcdadder bad2(.num1(x22), .num2(x12), .out(y2), .cin(c1), .carry(cout));

   assign c0 = 4'b0000; // in the first group of bcd, carry in is 0
   assign x22[3:0] = num1[7:4];
   assign x21[3:0] = num1[3:0];
   assign x12[3:0] = num2[7:4];
   assign x11[3:0] = num2[3:0];
   assign of = cout;
   assign out = {y2, y1};

`ifdef FORMAL
     assert property (num1[7:4] > 9 ||
                      num1[3:0] > 9 ||
                      num2[7:4] > 9 ||
                      num2[3:0] > 9 ||
                      of ||
                      (num1[7:4] * 10 + num1[3:0])
                      + (num2[7:4] * 10 + num2[3:0])
                      == (out[7:4] * 10 + out[3:0]));
   assert property (num1[7:4] > 9 ||
                    num1[3:0] > 9 ||
                    num2[7:4] > 9 ||
                    num2[3:0] > 9 ||
                    !of ||
                    (num1[7:4] * 10 + num1[3:0])
                    + (num2[7:4] * 10 + num2[3:0])
                    > 99);
`endif
   //don't care condition: overflow is detected
endmodule // tdigadder
