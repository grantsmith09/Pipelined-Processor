module register_16(writedata, write, readdata, clk, rst);

   input [15:0] writedata;
   input write, clk, rst;

   output [15:0] readdata;

   wire [15:0] writeEnable; 
  

   dff ff0[15:0](.q(readdata), .d(writeEnable), .clk(clk), .rst(rst));

   mux2_1_16 mux0(.Out(writeEnable), .in1(readdata), .in2(writedata), .sel(write));

endmodule
