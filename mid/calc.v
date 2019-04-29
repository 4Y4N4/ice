module top(
           input [7:0]  num1,
           input [7:0]  num2,
           output [7:0] out,
           output       flowIndicator,

           input        sel,
           output       A,
           output       B,
           output       C,
           output       D,
           output       E,
           output       F,
           output       G,
           output       DOT,
           output [7:0] ssg_row,
           input        clk);

   wire [7:0]  x1;
   wire [7:0]  x2;
   wire        s;
   wire [7:0]  yadd;
   wire [7:0]  ysub;
   wire [7:0]  y1;
   wire [7:0]  y;
   wire        u_f;
   wire        o_f;
   wire        u_o_f;

 
   assign x1[7:0] = num1[7:0];
   assign x2[7:0] = num2[7:0];
   assign out[7:0] = y[7:0];
   assign s = sel;

   tdigadder add(.num1(x1), .num2(x2), .out(yadd), .of(o_f));
   bcdsub sub(.num1(x1), .num2(x2), .out(ysub), .uf(u_f));

   assign y = s ? yadd : ysub+1;
   assign u_o_f = s ? o_f: u_f;
   assign flowIndicator = u_o_f;
   
   reg [7:0] ssgsel;
   wire [7:0] ssgfnt;
   reg [15:0] cnt;
   reg [2:0]  fnd_rowsel;
   wire [3:0]  digit [7:0];
   always@ (posedge clk)
     begin
        cnt <= cnt+1'b1;
     end

   always @(posedge cnt[14])
     begin
        fnd_rowsel <= fnd_rowsel+1;
     end

   always @ (fnd_rowsel)
     begin
        case(fnd_rowsel)
          3'h0: ssgsel <= 8'b00000001;
          3'h1: ssgsel <= 8'b00000010;
          3'h2: ssgsel <= 8'b00000000;
          3'h3: ssgsel <= 8'b00001000;
          3'h4: ssgsel <= 8'b00010000;
          3'h5: ssgsel <= 8'b00000000;
          3'h6: ssgsel <= 8'b01000000;
          3'h7: ssgsel <= 8'b10000000;
        endcase // case (fnd_rowsel)
     end // always @ (fnd_rowsel)

   assign digit[1] = x1[3:0];
   assign digit[0] = x1[7:4];
   assign digit[4] = x2[3:0];
   assign digit[3] = x2[7:4];
   assign digit[7] = y[3:0];
   assign digit[6] = y[7:4];

   ssgfont sf(.num(digit[fnd_rowsel]), .ssg(ssgfnt), .dot(1'b0));
   assign {A, B, C, D, E, F, G, DOT} = ssgfnt;
   assign ssg_row[7:0] = ssgsel[7:0];
endmodule
