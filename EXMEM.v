module EXMEM(B_in, B_out, ALURes_in, ALURes_out, nextPC_in, nextPC_out, pc_in, pc_out, AB_in, AB_out, writeregsel_in, writeregsel_out, JAL_in, JAL_out, branch_in, branch_out, 
	     MemToReg_in, MemToReg_out, MemWrite_in, MemWrite_out, RegWrite_in, RegWrite_out, halt_in, halt_out, en, clk, rst);
  
   input [15:0] B_in;
   input [15:0] ALURes_in;
   input [15:0] nextPC_in;
   input [15:0] pc_in;
   input [4:0] AB_in;
   input [2:0] writeregsel_in;
   input JAL_in;
   input branch_in;
   input MemToReg_in;
   input MemWrite_in;
   input RegWrite_in;
   input halt_in;
   input en;
   input clk, rst; 

   output [15:0] B_out;
   output [15:0] ALURes_out;
   output [15:0] nextPC_out;
   output [15:0] pc_out;
   output [4:0] AB_out;
   output [2:0] writeregsel_out;
   output JAL_out;
   output branch_out;
   output MemToReg_out;
   output MemWrite_out;
   output RegWrite_out;
   output halt_out;

   // 16 Bit Registers
   register_16 B_Reg(.writedata(B_in), .write(en), .readdata(B_out), .clk(clk), .rst(rst));
   register_16 ALURes_Reg(.writedata(ALURes_in), .write(en), .readdata(ALURes_out), .clk(clk), .rst(rst));
   register_16 nextPC_Reg(.writedata(nextPC_in), .write(en), .readdata(nextPC_out), .clk(clk), .rst(rst));
   register_16 pc_Reg(.writedata(pc_in), .write(en), .readdata(pc_out), .clk(clk), .rst(rst));

   // 5 Bit Register
   register_5 AB_Reg(.writedata(AB_in), .write(en), .readdata(AB_out), .clk(clk), .rst(rst));

   // 3 Bit Register
   register_3 writeregsel_Reg(.writedata(writeregsel_in), .write(en), .readdata(writeregsel_out), .clk(clk), .rst(rst));

   // 1 Bit Registers
   register_1 JAL_Reg(.writedata(JAL_in), .write(en), .readdata(JAL_out), .clk(clk), .rst(rst));
   register_1 branch_Reg(.writedata(branch_in), .write(en), .readdata(branch_out), .clk(clk), .rst(rst));
   register_1 MemToReg_Reg(.writedata(MemToReg_in), .write(en), .readdata(MemToReg_out), .clk(clk), .rst(rst));
   register_1 MemWrite_Reg(.writedata(MemWrite_in), .write(en), .readdata(MemWrite_out), .clk(clk), .rst(rst));
   register_1 RegWrite_Reg(.writedata(RegWrite_in), .write(en), .readdata(RegWrite_out), .clk(clk), .rst(rst));
   register_1 halt_Reg(.writedata(halt_in), .write(en), .readdata(halt_out), .clk(clk), .rst(rst));

endmodule