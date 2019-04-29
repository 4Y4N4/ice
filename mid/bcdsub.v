module bcdsub(
              //bcd subtractor using 1's complement method
 input [7:0]  num1,
 input [7:0]  num2,
 output [7:0] out,
 output       uf  );

   wire [3:0] x12;
   wire [3:0] x11;
   wire [3:0] x22;
   wire [3:0] x21;
   wire [3:0] y2;
   wire [3:0] y1;
   wire       lc; //lower case carry, it goes to upper case
   wire       hc; //upper case carry, cause it's 2-bit subtrastor, it goes
                  //to lower case(end-round-carry)

   wire [3:0] htmp;//
   wire [3:0] ltmp;//result of adder1x


   //we just care about non-underflow case, so end-around-carry is always 1
   //adder2s' transfered value is real result(EAC == 1)

   wire [3:0] comp; //if lower cases' carry is 1, comp is 4'b0000
                    //other, comp is 4'b1010


   assign x12[3:0] = num1[7:4];
   assign x11[3:0] = num1[3:0];
   assign x22[3:0] = ~(num2[7:4]);
   assign x21[3:0] = ~(num2[3:0]);

   Cla add12(.num1(x12), .num2(x22), .cin(1'b0), .out(htmp), .car(hc));
   Cla add11(.num1(x11), .num2(x21), .cin(1'b0), .out(ltmp), .car(lc));

   assign comp[3:0] = {!lc, 1'b0, !lc, 1'b0};
   Cla add22(.num1(htmp), .num2(4'b0000), .cin(lc), .out(y2), .car());
   Cla add21(.num1(ltmp), .num2(comp), .cin(hc), .out(y1), .car());

   assign out[7:0] = {y2,y1};
   assign uf = !hc;
`ifdef FORMAL
   assert property (num1[7:4] > 9 ||
                    num1[3:0] > 9 ||
                    num2[7:4] > 9 ||
                    num2[3:0] > 9 ||
                    uf ||
                    ((num1[7:4] * 10) + num1[3:0]) - ((num2[7:4] * 10) + num2[3:0]) == ((out[7:4] * 10) + out[3:0]));
`endif
   //as we wrote in avobe, underflow case is don't care condition
endmodule // tbcdsub
