module register_1(writedata, write, readdata, clk, rst);

   input writedata;
   input write, clk, rst;

   output readdata;

   wire writeEnable; 
  

   dff ff0(.q(readdata), .d(writeEnable), .clk(clk), .rst(rst));

   mux2_1 mux0(.Out(writeEnable), .in1(readdata), .in2(writedata), .sel(write));

endmodule
