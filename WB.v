module WB(ALURes, readdata, nextPC, JAL, MemToReg, writedata);

  input [15:0] ALURes;
  input [15:0] readdata;
  input [15:0] nextPC;
  input JAL;
  input MemToReg;


  output [15:0] writedata;

  mux4_1_16 wbmux(.Out(writedata), .in1(ALURes), .in2(readdata), .in3(nextPC), .in4(16'hxxxx), .sel({JAL, MemToReg}));

endmodule
