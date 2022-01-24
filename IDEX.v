module IDEX(inNextPC, outNextPC, inInstr, outInstr, A_in, B_in, A_out, B_out, invA_in, invB_in, Cin_in, invA_out, invB_out, Cin_out, AB_in, AB_out, 
	    signExtend1_in, signExtend2_in, signExtend3_in, signExtend1_out, signExtend2_out, signExtend3_out, zeroExtend1_in, zeroExtend2_in, zeroExtend1_out, zeroExtend2_out, SignExtend_in, SignExtend_out, 
	    ALUSrc_in, ALUSrc_out, RegDst_in, RegDst_out, RegWrite_in, RegWrite_out, MemWrite_in, MemToReg_in, MemWrite_out, MemToReg_out, halt_in, halt_out, stall, en, clk, rst);

   input [15:0] inNextPC, inInstr;
   input [15:0] A_in, B_in;
   input invA_in, invB_in, Cin_in;
   input [4:0] AB_in;
   input [15:0] signExtend1_in, signExtend2_in, signExtend3_in;
   input [15:0] zeroExtend1_in, zeroExtend2_in;
   input SignExtend_in;
   input [1:0] ALUSrc_in;
   input [1:0] RegDst_in;
   input RegWrite_in;
   input MemWrite_in, MemToReg_in;
   input halt_in, stall, en;
   input clk, rst;

   output [15:0] outNextPC, outInstr;
   output [15:0] A_out, B_out;
   output invA_out, invB_out, Cin_out;
   output [4:0] AB_out;
   output [15:0] signExtend1_out, signExtend2_out, signExtend3_out;
   output [15:0] zeroExtend1_out, zeroExtend2_out;
   output SignExtend_out;
   output [1:0] ALUSrc_out;
   output [1:0] RegDst_out;
   output RegWrite_out;
   output MemWrite_out, MemToReg_out;
   output halt_out;


   wire [15:0] selInstr;
   wire selRegWrite;
   wire selMemWrite;
   wire selMemToReg;
   wire selhalt;

   // Next PC Register
   register_16 nextPC(.writedata(inNextPC), .write(en), .readdata(outNextPC), .clk(clk), .rst(rst));

  // Instruction Register
  assign selInstr = (stall) ? 16'h0800 : inInstr;
  register_16 instr(.writedata(selInstr), .write(en), .readdata(outInstr), .clk(clk), .rst(rst));

  // A, B, Cin, inA, invB Registers
  register_16 A_Reg(.writedata(A_in), .write(en), .readdata(A_out), .clk(clk), .rst(rst));
  register_16 B_Reg(.writedata(B_in), .write(en), .readdata(B_out), .clk(clk), .rst(rst));
  register_1 Cin_Reg(.writedata(Cin_in), .write(en), .readdata(Cin_out), .clk(clk), .rst(rst));
  register_1 invA_Reg(.writedata(invA_in), .write(en), .readdata(invA_out), .clk(clk), .rst(rst));
  register_1 invB_Reg(.writedata(invB_in), .write(en), .readdata(invB_out), .clk(clk), .rst(rst));

  // AB Register
  register_5 AB_Reg(.writedata(AB_in), .write(en), .readdata(AB_out), .clk(clk), .rst(rst));

  // Sign Extend and Zero Extend Registers
  register_16 signExtend1_Reg(.writedata(signExtend1_in), .write(en), .readdata(signExtend1_out), .clk(clk), .rst(rst));
  register_16 signExtend2_Reg(.writedata(signExtend2_in), .write(en), .readdata(signExtend2_out), .clk(clk), .rst(rst));
  register_16 signExtend3_Reg(.writedata(signExtend3_in), .write(en), .readdata(signExtend3_out), .clk(clk), .rst(rst));
  register_16 zeroExtend1_Reg(.writedata(zeroExtend1_in), .write(en), .readdata(zeroExtend1_out), .clk(clk), .rst(rst));
  register_16 zeroExtend2_Reg(.writedata(zeroExtend2_in), .write(en), .readdata(zeroExtend2_out), .clk(clk), .rst(rst));
  register_1 SignExtend_Reg(.writedata(SignExtend_in), .write(en), .readdata(SignExtend_out), .clk(clk), .rst(rst));

  // ALUSrc and RegDst Registers
  register_2 ALUSrc_Reg(.writedata(ALUSrc_in), .write(en), .readdata(ALUSrc_out), .clk(clk), .rst(rst));
  register_2 RegDst_Reg(.writedata(RegDst_in), .write(en), .readdata(RegDst_out), .clk(clk), .rst(rst));

  // RegWrite Register
  assign selRegWrite = (stall) ? 1'b0 : RegWrite_in;
  register_1 RegWrite_Reg(.writedata(selRegWrite), .write(en), .readdata(RegWrite_out), .clk(clk), .rst(rst));

  // MemWrite Register 
  assign selMemWrite = (stall) ? 1'b0 : MemWrite_in;
  register_1 MemWrite_Reg(.writedata(selMemWrite), .write(en), .readdata(MemWrite_out), .clk(clk), .rst(rst));

  // MemToReg Register
  assign selMemToReg = (stall) ? 1'b0 : MemToReg_in;
  register_1 MemToReg_Reg(.writedata(selMemToReg), .write(en), .readdata(MemToReg_out), .clk(clk), .rst(rst));

  // Halt Register
  assign selhalt = (stall) ? 1'b0 : halt_in;
  register_1 halt_Reg(.writedata(selhalt), .write(en), .readdata(halt_out), .clk(clk), .rst(rst));

endmodule 
