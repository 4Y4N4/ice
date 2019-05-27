module final(
               input         clk,
               input         rst,
               input [15:0]  switch,
               output [23:0] led,
               output        A,
               output        B,
               output        C,
               output        D,
               output        E,
               output        F,
               output        G,
               output        DP,
               output [7:0]  fnd_row,
               output        lcd_rs,
               output        lcd_rw,
               output        lcd_clk,
               output [7:0]  lcd_data
               );

   localparam CLKDIV = 19;
   localparam FNDCLKDIV = 12;
   wire [6:0]                hex0, hex1, hex3;

   reg [CLKDIV:0]            clkdiv;
   reg [7:0]                 fnd_rowsel;
   reg [7:0]                 segout;
   reg [2:0]                 bcdoff;

   always@(posedge clk)
     begin
        clkdiv <= clkdiv + 1;
     end

   always@(posedge clkdiv[FNDCLKDIV])
     begin
        if (bcdoff == 2)
          begin
             bcdoff <= 0;
          end
        else
          begin
             bcdoff <= bcdoff + 1;
          end
     end // always@ (posedge clkdiv[FNDCLKDIV])

   always @ (bcdoff)
     begin
        case(bcdoff)
          3'h0: fnd_rowsel <= 8'b00000001;
          3'h1: fnd_rowsel <= 8'b00000010;
          3'h2: fnd_rowsel <= 8'b00001000;
        endcase // case (bcdoff)
     end

   always @(bcdoff)
     begin
        case(bcdoff)
          3'h0: segout <= hex0 << 1;
          3'h1: segout <= hex1 << 1;
          3'h2: segout <= hex3 << 1;
        endcase // case (bcdoff)
     end

   logic_design ld(.SW({switch[5], switch[3:0]}),
                   .CLOCK_50(clk),
                   .HEX0(hex1),
                   .HEX1(hex0),
                   .HEX3(hex3));

   assign {A, B, C, D, E, F, G, DP} = ~segout;
   assign fnd_row = fnd_rowsel;
   assign led[0] = switch[5];
endmodule // final
