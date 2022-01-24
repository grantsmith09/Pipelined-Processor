module memory(writedata, ALURes, MemRead, MemWrite, halt, clk, rst, readdata);

  input [15:0] writedata;
  input [15:0] ALURes;
  input MemRead, MemWrite;
  input halt;
  input clk, rst;
  output [15:0] readdata;


  wire R_W;


  assign R_W = MemRead | MemWrite;

  // Data Memory
  memory2c dataMEM(.data_out(readdata), .data_in(writedata), .addr(ALURes), .enable(R_W), .wr(MemWrite), .createdump(halt), .clk(clk), .rst(rst));

endmodule
