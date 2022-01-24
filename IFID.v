module IFID(inNextPC, inInstr, outNextPC, outInstr, en, clk, rst);

   input [15:0] inNextPC, inInstr;
   input en;
   input clk, rst;


   output [15:0] outNextPC, outInstr;

   wire [15:0] selInstr;

   // Next PC Register
   register_16 nxtPCReg(.writedata(inNextPC), .write(en), .readdata(outNextPC), .clk(clk), .rst(rst));

   // NOP Instruction 
   assign selInstr = (rst) ? 16'h0800 : inInstr;

   // Instruction Register
   register_16 InstrReg(.writedata(selInstr), .write(en), .readdata(outInstr), .clk(clk), .rst(1'b0));

endmodule
