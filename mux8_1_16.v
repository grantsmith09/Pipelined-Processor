module mux8_1_16(Out, in1, in2, in3, in4, in5, in6, in7, in8, sel);

  input [15:0] in1, in2, in3, in4, in5, in6, in7, in8;
  input [2:0] sel;
  output [15:0] Out;

  mux8_1 mux0[15:0](.Out(Out), .in1(in1), .in2(in2), .in3(in3), .in4(in4), .in5(in5), .in6(in6), .in7(in7), .in8(in8), .sel(sel[2:0]));

endmodule
