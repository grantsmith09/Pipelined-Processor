module mux2_1(Out, in1, in2, sel);

  input in1, in2; 
  input sel; 
  output Out;


  wire notS, nand1, nand2;

  assign notS = ~sel;  

  assign nand1 = ~(in1 & notS);
  assign nand2 = ~(in2 & sel);

  assign Out = ~(nand1 & nand2);

endmodule
