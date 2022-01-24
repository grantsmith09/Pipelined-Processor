module register_2(writedata, write, readdata, clk, rst);

   input [1:0] writedata;
   input write, clk, rst;

   output [1:0] readdata;

   wire [1:0] writeEnable; 
  

   dff ff0[1:0](.q(readdata), .d(writeEnable), .clk(clk), .rst(rst));

   mux2_1 mux0[1:0](.Out(writeEnable), .in1(readdata), .in2(writedata), .sel(write));

endmodule
