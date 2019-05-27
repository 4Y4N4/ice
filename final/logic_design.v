module logic_design(
                    input [4:0]  SW,
                    input        CLOCK_50,
                    output [0:6] HEX0,
                    output [0:6] HEX1,
                    output [0:6] HEX3);

   wire     add4;
   wire     add8;
   wire     add12;
   wire     sub8;
   wire     rst;
   wire     clk;
   reg [2:0] flip;
   reg [23:0] cnt;

   assign add4 = SW [0];
   assign add8 = SW [1];
   assign add12 = SW [2];
   assign sub8 = SW [3];
   assign rst = SW[4];
   assign clk = CLOCK_50;

   always @(posedge clk)
     begin
        cnt <= cnt+ 1'b1;
     end


   always @(posedge cnt[23], posedge rst)
     begin
        if (rst)
          begin
             flip <= 0;
          end
        else
          begin
             if(add4)
               begin
                  flip[0] <= flip[0] ^((flip[1]&&flip[2])&&add4);
                  flip[1] <= flip[1] ^((!flip[0])&&flip[2]&&add4);
                  flip[2] <= flip[2] ^(((!flip[0])&&add4)||((!flip[2])&&add4));
               end
             else if(add8)
               begin
                  flip[0] <= flip[0] ^(add8 && flip[1]);
                  flip[1] <= flip[1] ^(add8 && (!flip[0]));
                  flip[2] <= flip[2];
               end
             else if(add12)
               begin
                  flip[0] <= flip[0] ^((!flip[0]) && (flip[1] ^ flip[2])&&add12);
                  flip[1] <= flip[1] ^(((!flip[0]) && (!flip[2])) && add12);
                  flip[2] <= flip[2] ^((!flip[0]) && (!(flip[1] && flip[2])) && add12);
               end
             else if(sub8)
               begin
                  flip[0] <= flip[0] ^(flip[0] && sub8);
                  flip[1] <= flip[1] ^((flip[0] ^ flip[1])&&sub8);
                  flip[2] <= flip[2];
               end
          end
     end

   wire [4:0] num;
   reg [3:0] BCD [1:0];
   assign num = {flip[0], flip[1], flip[2], 2'b00};
   always @(*)
     begin
        if (num == 20)
          begin
             BCD[1] <= 4'b0010;
             BCD[0] <= 4'b0000;
          end
        else if ((10 == num) ||((10 < num) && (num < 19)))
          begin
             BCD[1] <= 4'b0001;
             BCD[0] <= (num - 10);
          end
        else if (num < 10)
          begin
             BCD[1] <= 4'b0000;
             BCD[0] <= num[3:0];
          end
     end // always @ (*)

   wire [3:0]  digit [2:0];

   assign digit[2] = {2'b00, flip[0], flip[1]};
   assign digit[1] = BCD[1];
   assign digit[0] = BCD[0];

   ssgfont sf0(.num(digit[0]),
               .ssg(HEX0));
   ssgfont sf1(.num(digit[1]),
               .ssg(HEX1));
   ssgfont sf2(.num(digit[2]),
               .ssg(HEX3));
endmodule
