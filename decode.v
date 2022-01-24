module decode(instr, writedata, writeregsel, inRegWrite, clk, rst, signExtend1, signExtend2, signExtend3, zeroExtend1, zeroExtend2, SignExtend, A, B, ALUSrc, RegDst, AB, outRegWrite, MemWrite, MemToReg, invA, invB, Cin, halt, err);

   input [15:0] instr;
   input [15:0] writedata;
   input [2:0] writeregsel;
   input inRegWrite;
   input clk, rst;

   output [15:0] signExtend1, signExtend2, signExtend3;
   output [15:0] zeroExtend1, zeroExtend2;
   output SignExtend; 
   output [15:0] A, B;
   output [1:0] ALUSrc;
   output [1:0] RegDst;
   output [4:0] AB;
   output outRegWrite;
   output MemWrite, MemToReg;
   output invA, invB, Cin;
   output halt;
   output err;

   // Sign Extend based on instr[4:0]
   assign signExtend1 = {{11{instr[4]}}, instr[4:0]};

   // Sign Extend based on instr[7:0]
   assign signExtend2 = {{8{instr[7]}}, instr[7:0]};

   // Sign Extend based on instr[10:0]
   assign signExtend3 = {{5{instr[10]}}, instr[10:0]};

   // Zero Extend based on instr[4:0]
   assign zeroExtend1 = {{11{1'b0}}, instr[4:0]};

   // Zero Extend based on instr[7:0]
   assign zeroExtend2 = {{8{1'b0}}, instr[7:0]};

   // Control Unit 
   control c1(.instr(instr), .ALUSrc(ALUSrc), .RegDst(RegDst), .AB(AB), .RegWrite(outRegWrite), .MemWrite(MemWrite), .MemToReg(MemToReg), .invA(invA), .invB(invB), .Cin(Cin), .SignExtend(SignExtend), .halt(halt));

   // Register File in decode stage
   rf rf0(.read1data(A), .read2data(B), .err(err), .clk(clk), .rst(rst), .read1regsel(instr[10:8]), .read2regsel(instr[7:5]), .writeregsel(writeregsel), .writedata(writedata), .write(inRegWrite));

endmodule

