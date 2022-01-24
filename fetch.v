module fetch(PCnew, enPC, AB_forward, AB_forward_IDEX, AB_forward_EXMEM, AB_forward_MEMWB, stall, branchEXMEM, halt, clk, rst, PCnext, instr);

   input [15:0] PCnew;
   input enPC;
   input AB_forward, AB_forward_IDEX, AB_forward_EXMEM, AB_forward_MEMWB;
   input stall, branchEXMEM;
   input halt;
   input clk, rst;

   output [15:0] PCnext;
   output [15:0] instr;

   wire [15:0] PCcurr;
   wire [15:0] PCtemp;
   wire [15:0] increment;
   wire [15:0] instrTemp;
   wire branchStall;

   // PC Register 
   register_16 PCreg(.writedata(PCtemp), .write(enPC), .readdata(PCcurr), .clk(clk), .rst(rst));

   // Instruction Memory for fetching instr based on pc
   memory2c instrMem(.data_out(instrTemp), .data_in(16'h0000), .addr(PCcurr), .enable(1'b1), .wr(1'b0), .createdump(halt), .clk(clk), .rst(rst));
 
   // Will have a branch stall if any stages are forwarding
   assign branchStall = AB_forward | AB_forward_IDEX | AB_forward_EXMEM | AB_forward_MEMWB;

   // Instr will be NOP if there is a branch stall
   assign instr = (branchStall) ? 16'h0800 : instrTemp;

   // Increment PC by 0 if there is no stall or branchstall otherwise increment by 2
   assign increment = (stall | branchStall) ? 16'h0000 : 16'h0002;

   cla_16 PCinc(.A(PCcurr), .B(increment), .Cin(1'b0), .sum(PCnext), .Cout(), .Pout(), .Gout());

   assign PCtemp = (branchEXMEM) ? PCnew : PCnext;

endmodule