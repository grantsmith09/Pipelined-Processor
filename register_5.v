module register_5(writedata, write, readdata, clk, rst);

   input [4:0] writedata;
   input write, clk, rst;

   output [4:0] readdata;

   wire [4:0] writeEnable; 
  

   dff ff0[4:0](.q(readdata), .d(writeEnable), .clk(clk), .rst(rst));

   mux2_1 mux0[4:0](.Out(writeEnable), .in1(readdata), .in2(writedata), .sel(write));

endmodule
