/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // Fetch wires 
   wire [15:0] PCnext, instr;

   // IFID wires
   wire [15:0] outNextPC_IFID, outInstr_IFID;

   // Decode wires 
   wire [15:0] signExtend1, signExtend2, signExtend3;
   wire [15:0] zeroExtend1, zeroExtend2;
   wire SignExtend; 
   wire [15:0] A, B;
   wire [1:0] ALUSrc;
   wire [1:0] RegDst;
   wire [4:0] AB;
   wire RegWrite;
   wire MemWrite, MemToReg;
   wire invA, invB, Cin;
   wire halt;
   wire err;

   // IDEX wires
   wire [15:0] outNextPC_IDEX, outInstr_IDEX;
   wire [15:0] A_out_IDEX, B_out_IDEX;
   wire invA_out_IDEX, invB_out_IDEX, Cin_out_IDEX;
   wire [4:0] AB_out_IDEX;
   wire [15:0] signExtend1_out_IDEX, signExtend2_out_IDEX, signExtend3_out_IDEX;
   wire [15:0] zeroExtend1_out_IDEX, zeroExtend2_out_IDEX;
   wire SignExtend_out_IDEX;
   wire [1:0] ALUSrc_out_IDEX;
   wire [1:0] RegDst_out_IDEX;
   wire RegWrite_out_IDEX;
   wire MemWrite_out_IDEX, MemToReg_out_IDEX;
   wire halt_out_IDEX;

   // Execute wires
   wire [15:0] ALURes;
   wire [15:0] pc;
   wire [2:0] writeregsel;
   wire JAL;
   wire branch;

   // EXMEM wires
   wire [15:0] B_out_EXMEM;
   wire [15:0] ALURes_out_EXMEM;
   wire [15:0] nextPC_out_EXMEM;
   wire [15:0] pc_out_EXMEM;
   wire [4:0] AB_out_EXMEM;
   wire [2:0] writeregsel_out_EXMEM;
   wire JAL_out_EXMEM;
   wire branch_out_EXMEM;
   wire MemToReg_out_EXMEM;
   wire MemWrite_out_EXMEM;
   wire RegWrite_out_EXMEM;
   wire halt_out_EXMEM;

   // Memory wires
   wire [15:0] readdata;

   // MEMWB wires
   wire [15:0] ALURes_out_MEMWB;
   wire [15:0] readdata_out_MEMWB;
   wire [15:0] nextPC_out_MEMWB;
   wire [15:0] pc_out_MEMWB;
   wire [4:0] AB_out_MEMWB;
   wire [2:0] writeregsel_out_MEMWB;
   wire RegWrite_out_MEMWB;
   wire MemToReg_out_MEMWB;
   wire JAL_out_MEMWB;
   wire branch_out_MEMWB;
   wire halt_out_MEMWB;

   // WB wires 
   wire [15:0] writedata;

   // Hazard wires 
   wire stall;
   wire enPC;
   wire enIFID;
   

   fetch f0(.PCnew(pc_out_MEMWB), .enPC(enPC), .AB_forward(|AB[4:2]), .AB_forward_IDEX(|AB_out_IDEX[4:2]), .AB_forward_EXMEM(|AB_out_EXMEM[4:2]), .AB_forward_MEMWB(|AB_out_MEMWB[4:2]), .stall(stall), 
            .branchEXMEM(branch_out_MEMWB), .halt(halt_out_MEMWB), .clk(clk), .rst(rst), .PCnext(PCnext), .instr(instr));


   IFID IFID0(.inNextPC(PCnext), .inInstr(instr), .outNextPC(outNextPC_IFID), .outInstr(outInstr_IFID), .en(enIFID), .clk(clk), .rst(rst));


   decode d0(.instr(outInstr_IFID), .writedata(writedata), .writeregsel(writeregsel_out_MEMWB), .inRegWrite(RegWrite_out_MEMWB), .clk(clk), .rst(rst), .signExtend1(signExtend1), .signExtend2(signExtend2), 
             .signExtend3(signExtend3), .zeroExtend1(zeroExtend1), .zeroExtend2(zeroExtend2), .SignExtend(SignExtend), .A(A), .B(B), .ALUSrc(ALUSrc), .RegDst(RegDst), .AB(AB), .outRegWrite(RegWrite), 
             .MemWrite(MemWrite), .MemToReg(MemToReg), .invA(invA), .invB(invB), .Cin(Cin), .halt(halt), .err(err));


   IDEX IDEX0(.inNextPC(outNextPC_IFID), .outNextPC(outNextPC_IDEX), .inInstr(outInstr_IFID), .outInstr(outInstr_IDEX), .A_in(A), .B_in(B), .A_out(A_out_IDEX), .B_out(B_out_IDEX), .invA_in(invA), .invB_in(invB), .Cin_in(Cin), 
              .invA_out(invA_out_IDEX), .invB_out(invB_out_IDEX), .Cin_out(Cin_out_IDEX), .AB_in(AB), .AB_out(AB_out_IDEX), .signExtend1_in(signExtend1), .signExtend2_in(signExtend2), .signExtend3_in(signExtend3), 
              .signExtend1_out(signExtend1_out_IDEX), .signExtend2_out(signExtend2_out_IDEX), .signExtend3_out(signExtend3_out_IDEX), .zeroExtend1_in(zeroExtend1), .zeroExtend2_in(zeroExtend2), 
              .zeroExtend1_out(zeroExtend1_out_IDEX), .zeroExtend2_out(zeroExtend2_out_IDEX), .SignExtend_in(SignExtend), .SignExtend_out(SignExtend_out_IDEX), .ALUSrc_in(ALUSrc), .ALUSrc_out(ALUSrc_out_IDEX), 
              .RegDst_in(RegDst), .RegDst_out(RegDst_out_IDEX), .RegWrite_in(RegWrite), .RegWrite_out(RegWrite_out_IDEX), .MemWrite_in(MemWrite), .MemToReg_in(MemToReg), .MemWrite_out(MemWrite_out_IDEX), 
              .MemToReg_out(MemToReg_out_IDEX), .halt_in(halt), .halt_out(halt_out_IDEX), .stall(stall), .en(1'b1), .clk(clk), .rst(rst));

   execute e0(.instr(outInstr_IDEX), .A(A_out_IDEX), .B(B_out_IDEX), .nextPC(outNextPC_IDEX), .signExtend1(signExtend1_out_IDEX), .signExtend2(signExtend2_out_IDEX), .signExtend3(signExtend3_out_IDEX), 
              .zeroExtend1(zeroExtend1_out_IDEX), .zeroExtend2(zeroExtend2_out_IDEX), .SignExtend(SignExtend_out_IDEX), .ALUSrc(ALUSrc_out_IDEX), .RegDst(RegDst_out_IDEX), .invA(invA_out_IDEX), 
              .invB(invB_out_IDEX), .Cin(Cin_out_IDEX), .ALURes(ALURes), .pc(pc), .writeregsel(writeregsel), .JAL(JAL), .branch(branch));

   EXMEM EXMEM0(.B_in(B_out_IDEX), .B_out(B_out_EXMEM), .ALURes_in(ALURes), .ALURes_out(ALURes_out_EXMEM), .nextPC_in(outNextPC_IDEX), .nextPC_out(nextPC_out_EXMEM), .pc_in(pc), .pc_out(pc_out_EXMEM), .AB_in(AB_out_IDEX), 
                .AB_out(AB_out_EXMEM), .writeregsel_in(writeregsel), .writeregsel_out(writeregsel_out_EXMEM), .JAL_in(JAL), .JAL_out(JAL_out_EXMEM), .branch_in(branch), .branch_out(branch_out_EXMEM), 
                .MemToReg_in(MemToReg_out_IDEX), .MemToReg_out(MemToReg_out_EXMEM), .MemWrite_in(MemWrite_out_IDEX), .MemWrite_out(MemWrite_out_EXMEM), .RegWrite_in(RegWrite_out_IDEX), .RegWrite_out(RegWrite_out_EXMEM), 
                .halt_in(halt_out_IDEX), .halt_out(halt_out_EXMEM), .en(1'b1), .clk(clk), .rst(rst));

   memory m0(.writedata(B_out_EXMEM), .ALURes(ALURes_out_EXMEM), .MemRead(MemToReg_out_EXMEM), .MemWrite(MemWrite_out_EXMEM), .halt(halt_out_EXMEM), .clk(clk), .rst(rst), .readdata(readdata));

   MEMWB MEMWB0(.ALURes_in(ALURes_out_EXMEM), .ALURes_out(ALURes_out_MEMWB), .readdata_in(readdata), .readdata_out(readdata_out_MEMWB), .nextPC_in(nextPC_out_EXMEM), .nextPC_out(nextPC_out_MEMWB), .pc_in(pc_out_EXMEM), 
                .pc_out(pc_out_MEMWB), .AB_in(AB_out_EXMEM), .AB_out(AB_out_MEMWB), .writeregsel_in(writeregsel_out_EXMEM), .writeregsel_out(writeregsel_out_MEMWB), .RegWrite_in(RegWrite_out_EXMEM), 
                .RegWrite_out(RegWrite_out_MEMWB), .MemToReg_in(MemToReg_out_EXMEM), .MemToReg_out(MemToReg_out_MEMWB), .JAL_in(JAL_out_EXMEM), .JAL_out(JAL_out_MEMWB), 
                .branch_in(branch_out_EXMEM), .branch_out(branch_out_MEMWB), .halt_in(halt_out_EXMEM), .halt_out(halt_out_MEMWB), .en(1'b1), .clk(clk), .rst(rst));

   WB WB0(.ALURes(ALURes_out_MEMWB), .readdata(readdata_out_MEMWB), .nextPC(nextPC_out_MEMWB), .JAL(JAL_out_MEMWB), .MemToReg(MemToReg_out_MEMWB), .writedata(writedata));

   hazard h0(.AB(AB), .writeregsel_IDEX(writeregsel), .writeregsel_EXMEM(writeregsel_out_EXMEM), .writeregsel_MEMWB(writeregsel_out_MEMWB), .RegRead_IFID_1(outInstr_IFID[10:8]), .RegRead_IFID_2(outInstr_IFID[7:5]), 
             .RegWrite_IDEX(RegWrite_out_IDEX), .RegWrite_EXMEM(RegWrite_out_EXMEM), .RegWrite_MEMWB(RegWrite_out_MEMWB), .stall(stall), .enPC(enPC), .enIFID(enIFID));
   
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
