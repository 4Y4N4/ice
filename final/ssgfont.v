module ssgfont (
   input [3:0]      num,
   output reg [6:0] ssg);

   always @(*)
     begin
        case(num)
          4'h0: ssg <= ~7'b1111110;
          4'h1: ssg <= ~7'b0110000;
          4'h2: ssg <= ~7'b1101101;
          4'h3: ssg <= ~7'b1111001;
          4'h4: ssg <= ~7'b0110011;
          4'h5: ssg <= ~7'b1011011;
          4'h6: ssg <= ~7'b0011111;
          4'h7: ssg <= ~7'b1110000;
          4'h8: ssg <= ~7'b1111111;
          4'h9: ssg <= ~7'b1110011;
        endcase // case (num)
     end // always @ (*)
endmodule // ssgfont
