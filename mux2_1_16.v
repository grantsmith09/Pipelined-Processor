module mux2_1_16(Out, in1, in2, sel);

  input [15:0] in1, in2;
  input sel;
  output [15:0] Out;

  mux2_1 mux2[15:0](.Out(Out), .in1(in1), .in2(in2), .sel(sel));

endmodule
