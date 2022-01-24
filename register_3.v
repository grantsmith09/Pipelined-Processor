module register_3(writedata, write, readdata, clk, rst);

   input [2:0] writedata;
   input write, clk, rst;

   output [2:0] readdata;

   wire [2:0] writeEnable; 
  

   dff ff0[2:0](.q(readdata), .d(writeEnable), .clk(clk), .rst(rst));

   mux2_1 mux0[2:0](.Out(writeEnable), .in1(readdata), .in2(writedata), .sel(write));

endmodule
