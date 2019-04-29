module ssgfont (
   input [3:0]      num,
   input            dot,
   output reg [7:0] ssg);

   always @(*)
     begin
        case(num)
          4'h0: ssg <= 8'b11111100 | dot;
          4'h1: ssg <= 8'b01100000 | dot;
          4'h2: ssg <= 8'b11011010 | dot;
          4'h3: ssg <= 8'b11110010 | dot;
          4'h4: ssg <= 8'b01100110 | dot;
          4'h5: ssg <= 8'b10110110 | dot;
          4'h6: ssg <= 8'b00111110 | dot;
          4'h7: ssg <= 8'b11100000 | dot;
          4'h8: ssg <= 8'b11111110 | dot;
          4'h9: ssg <= 8'b11100110 | dot;
        endcase // case (num)
     end // always @ (*)
endmodule // ssgfont
