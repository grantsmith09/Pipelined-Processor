module alu(A, B, opcode, twoLSB, invA, invB, Cin, ALUOut, Zero, Pos, Neg);

   input [15:0] A, B;
   input [4:0] opcode;
   input [1:0] twoLSB;
   input invA, invB, Cin;

   output reg [15:0] ALUOut;
   output Zero, Pos, Neg;

   wire [15:0] signedA, signedB, ALU_ADD, ALUOut_arithmetic, BTROut;
   wire g;

   // Invert inputs to ALU?
   assign signedA = (invA) ? ~A : A;
   assign signedB = (invB) ? ~B : B;

   // CLA for add operation
   cla_16 cla1(.A(signedA), .B(signedB), .Cin(Cin), .sum(ALU_ADD), .Cout(), .Pout(), .Gout(g));

   // Which arithmetic operation?
   mux4_1_16 mux0(.in1(ALU_ADD), .in2(ALU_ADD), .in3(signedA^signedB), .in4(signedA&signedB), .sel(twoLSB), .Out(ALUOut_arithmetic));

   // BTR (Bit Test and Rotate)
   BTR btr1(.Out(BTROut), .In(A));

   // Flag Assignment (Zero, Pos, Neg)
   assign Zero = (ALU_ADD == 16'h0000) ? 1'b1 : 1'b0;
   assign Neg = (ALU_ADD[15] & ~Zero);
   assign Pos = ~(ALU_ADD[15] | Zero);


/***************************************************
       Shift/Rotate Operations
***************************************************/
wire [15:0] shift1out;
wire [15:0] shift2out;

shifter shifter0 (.in(signedA), .shift_amt(signedB[3:0]), .opcode(opcode[1:0]), .out(shift1out));
shifter shifter1 (.in(signedA), .shift_amt(signedB[3:0]), .opcode(twoLSB[1:0]), .out(shift2out));

always @(*) begin 

	   case(opcode)

	      5'b00000: ALUOut = 16'hXXXX; // Halt
              

              5'b00001: ALUOut = 16'hXXXX; // NOP
	      
     
 	      5'b01000: ALUOut = ALU_ADD; // ADDI
 	     

      	      5'b01001: ALUOut = ALU_ADD; // SUBI
		

      	      5'b01010: ALUOut = signedA ^ signedB; // XORI
	

     	      5'b01011: ALUOut = signedA & signedB; // ANDNI


      	      5'b10100: ALUOut = shift1out; // ROLI


      	      5'b10101: ALUOut = shift1out; // SLLI


    	      5'b10110: ALUOut = shift1out; // RORI


     	      5'b10111: ALUOut = shift1out;// SRLI


      	      5'b10000: ALUOut = ALU_ADD; // ST


     	      5'b10001: ALUOut = ALU_ADD; // LD


      	      5'b10011: ALUOut = ALU_ADD; // STU


     	      5'b11001: ALUOut = BTROut; // BTR


      	      5'b11011: ALUOut = ALUOut_arithmetic; // ADD, SUB, XOR, ANDN


      	      5'b11010: ALUOut = shift2out; // ROL, SLL, ROR, SRL
	

     	      5'b11100: ALUOut = (Zero) ? 16'h0001 : 16'h0000; // SEQ


     	      5'b11101: ALUOut = ((A[15] & ~B[15])|(Neg & ~(A[15] ^ B[15]))) ? 16'h0001 : 16'h0000; // SLT
	

     	      5'b11110: ALUOut = (Zero|(A[15] & ~B[15])|(Neg & ~(A[15] ^ B[15]))) ? 16'h0001 : 16'h0000; // SLE
	

     	      5'b11111: ALUOut = (g) ? 16'h0001 : 16'h0000; // SCO
	

     	      5'b01100: ALUOut = ALU_ADD; // BEQZ
	

      	      5'b01101: ALUOut = ALU_ADD; // BNEZ
		

      	      5'b01110: ALUOut = ALU_ADD; // BLTZ
		

     	      5'b01111: ALUOut = ALU_ADD; // BGEZ
		

      	      5'b11000: ALUOut = B; // LBI
		

     	      5'b10010: ALUOut = ((A << 8) | B); // SLBI
	

      	      5'b00100: ALUOut = ALU_ADD; // J
		

      	      5'b00101: ALUOut = ALU_ADD; // JR
	

     	      5'b00110: ALUOut = ALU_ADD; // JAL		


      	      5'b00111: ALUOut = ALU_ADD; // JALR
	

              5'b00010: ALUOut = 16'hXXXX; // siic

            

     	      5'b00011: ALUOut = 16'hXXXX; // NOP / RTI

	      
              default: ALUOut = 16'hXXXX;
             
         endcase
       end

endmodule
