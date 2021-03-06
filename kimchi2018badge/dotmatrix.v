module top (
            input  clk,
            input  rst,
            output mat_r0,
            output mat_g0,
            output mat_b0,
            output mat_r1,
            output mat_g1,
            output mat_b1,
            output mat_row0,
            output mat_row1,
            output mat_row2,
            output mat_row3,
            output mat_clk,
            output mat_lat,
            output mat_oe,
            output LED0,
            output LED1,
            output LED2,
            output LED3,
            output LED4,
            output LED5,
            output LED6,
            output LED7
);
   reg             clkline;
   reg [3:0]       clkcnt;
   wire [2:0]      pixelbitoff;

   wire [1:0]      mat_r;
   wire [1:0]      mat_g;
   wire [1:0]      mat_b;
   wire [3:0]      mat_row;

   always @ (posedge clk)
     begin
        clkcnt <= clkcnt + 1;
        if (clkcnt == 4'b0111)
          begin
             clkline <= ~clkline;
             clkcnt <= 0;
          end
     end

   matrixdrv matdrv (clkline, rst, mat_r, mat_g, mat_b, mat_row, mat_clk, mat_lat, mat_oe);

   assign {mat_r0, mat_r1} = mat_r;
   assign {mat_g0, mat_g1} = mat_g;
   assign {mat_b0, mat_b1} = mat_b;
   assign {mat_row0, mat_row1, mat_row2, mat_row3} = mat_row;

   assign {LED0, LED1, LED2, LED3} = mat_row;
   assign LED7 = mat_clk;
   assign LED6 = clkline;
   assign LED5 = mat_lat;
endmodule
