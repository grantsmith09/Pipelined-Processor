module execute(instr, A, B, nextPC, signExtend1, signExtend2, signExtend3, zeroExtend1, zeroExtend2, SignExtend, ALUSrc, RegDst, invA, invB, Cin, ALURes, pc, writeregsel, JAL, branch);

   input [15:0] instr;
   input [15:0] A, B, nextPC;
   input [15:0] signExtend1, signExtend2, signExtend3;
   input [15:0] zeroExtend1, zeroExtend2;
   input SignExtend;
   input [1:0] ALUSrc;
   input [1:0] RegDst;
   input invA, invB, Cin;

   output [15:0] ALURes;
   output [15:0] pc;
   output [2:0] writeregsel;
   output JAL;
   output branch;

   wire [15:0] select5extension, select8extension;
   wire [15:0] Binput;
   wire Zero, Neg, Pos;
   wire branchsel;
   wire JMP, JR;
   wire [15:0] branchIncrement;
   wire [15:0] PCinc;
   wire [15:0] pc_temp1, pc_temp2;

   assign select5extension = (SignExtend) ? signExtend1 : zeroExtend1;
   assign select8extension = (SignExtend) ? signExtend2 : zeroExtend2;

   // B Input to the ALU
   mux4_1_16 muxselB(.Out(Binput), .in1(B), .in2(select5extension), .in3(select8extension), .in4(16'h0000), .sel(ALUSrc));

   // ALU Instantiation
   alu alu1(.A(A), .B(Binput), .opcode(instr[15:11]), .twoLSB(instr[1:0]), .invA(invA), .invB(invB), .Cin(Cin), .ALUOut(ALURes), .Zero(Zero), .Pos(Pos), .Neg(Neg));

   // RegDst Select
   mux4_1_3 RegDst_sel(.Out(writeregsel), .in1(instr[4:2]), .in2(instr[7:5]), .in3(instr[10:8]), .in4(3'b111), .sel(RegDst));

   // Branch Instantiation
   branch b1(.Zero(Zero), .Pos(Pos), .Neg(Neg), .opcode(instr[15:11]), .branchsel(branchsel));
   
   // Jump Instantiation
   jump j1(.opcode(instr[15:11]), .JMP(JMP), .JR(JR), .JAL(JAL));

   assign branch = branchsel | JMP | JR;
   assign branchIncrement = (branchsel) ? signExtend2 : 16'h0000;
   assign PCinc = (JMP) ? signExtend3 : branchIncrement;

   // New PC value
   cla_16 cla1(.A(nextPC), .B(PCinc), .Cin(1'b0), .sum(pc_temp1), .Cout(), .Pout(), .Gout());

   // New JR value
   cla_16 cla2(.A(A), .B(signExtend2), .Cin(1'b0), .sum(pc_temp2), .Cout(), .Pout(), .Gout());

   assign pc = JR ? pc_temp2 : pc_temp1;

endmodule	
