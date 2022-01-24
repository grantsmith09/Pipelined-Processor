module hazard(AB, writeregsel_IDEX, writeregsel_EXMEM, writeregsel_MEMWB, RegRead_IFID_1, RegRead_IFID_2, RegWrite_IDEX, RegWrite_EXMEM, RegWrite_MEMWB, stall, enPC, enIFID);

   input [4:0] AB;
   input [2:0] writeregsel_IDEX, writeregsel_EXMEM, writeregsel_MEMWB;
   input [2:0] RegRead_IFID_1, RegRead_IFID_2;
   input RegWrite_IDEX, RegWrite_EXMEM, RegWrite_MEMWB;

   output stall;
   output enPC;
   output enIFID;

   wire hazard1, hazard2, hazard3, hazard4, hazard5, hazard6;
   wire stall1, stall2, stall3;

   // Stall between IFID and IDEX
   assign hazard1 = AB[1] & (writeregsel_IDEX == RegRead_IFID_1);
   assign hazard2 = AB[0] & (writeregsel_IDEX == RegRead_IFID_2);
   assign stall1 = RegWrite_IDEX & (hazard1 | hazard2);

   // Stall between IFID and EXMEM
   assign hazard3 = AB[1] & (writeregsel_EXMEM == RegRead_IFID_1);
   assign hazard4 = AB[0] & (writeregsel_EXMEM == RegRead_IFID_2);
   assign stall2 = RegWrite_EXMEM & (hazard3 | hazard4);

   // Stall between IFID and MEMWB
   assign hazard5 = AB[1] & (writeregsel_MEMWB == RegRead_IFID_1);
   assign hazard6 = AB[0] & (writeregsel_MEMWB == RegRead_IFID_2);
   assign stall3 = RegWrite_MEMWB & (hazard5 | hazard6);

   assign stall = stall1 | stall2 | stall3;
   assign enPC = (stall) ? 1'b0 : 1'b1;
   assign enIFID = (stall) ? 1'b0 : 1'b1;

endmodule