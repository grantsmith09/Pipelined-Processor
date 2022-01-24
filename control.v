module control(instr, ALUSrc, RegDst, AB, RegWrite, MemWrite, MemToReg, invA, invB, Cin, SignExtend, halt);

	input [15:0] instr;	
	
	output reg [1:0] ALUSrc; // Which "B" is ALU taking
	output reg [1:0] RegDst; // Can be 4 different locations 
        output reg [4:0] AB;
	output reg RegWrite; 
	output reg MemWrite; 
	output reg MemToReg; 
	output reg invA, invB, Cin;
        output reg SignExtend;
	output reg halt; 

	/**********************************
	  ALUSrc: 
	 	00 = read2data
	 	01 = Imm[4:0] 
	 	10 = Imm[7:0] 
		11 = ZER0
	/*********************************/


	/**********************************
	  RegDst:
		00 = instr[4:2]
		01 = instr[7:5]
		10 = instr[10:8]
		11 = R7
	**********************************/	
  
	always @(*) begin 
		 ALUSrc = 2'b11;
	  	 RegDst = 2'b11;
		 AB = 5'b00000;
	  	 RegWrite = 1'b0; 
	         MemWrite = 1'b0; 
	         MemToReg = 1'b0; 
		 invA = 1'b0;
		 invB = 1'b0;
		 Cin = 1'b0;
		 SignExtend = 1'b0;
		 halt = 1'b0;
 	
	   case({instr[15:11]})

	      5'b00000: begin // Halt
	  	 RegDst = 2'b00;
		 halt = 1'b1;
              end

              5'b00001: begin // NOP
	  	 RegDst = 2'b00;
	      end
     
 	      5'b01000: begin // ADDI
		 ALUSrc = 2'b01;
	  	 RegDst = 2'b01;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
	         SignExtend = 1'b1;
 	      end

      	      5'b01001: begin // SUBI
		 ALUSrc = 2'b01;
	  	 RegDst = 2'b01;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
	         invA = 1'b1;
	 	 Cin = 1'b1;
		 SignExtend = 1'b1;
              end

      	      5'b01010: begin // XORI
	 	 ALUSrc = 2'b01;
	  	 RegDst = 2'b01;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
              end

     	      5'b01011: begin // ANDNI
		 ALUSrc = 2'b01;
	  	 RegDst = 2'b01;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
		 invB = 1'b1;
              end

      	      5'b10100: begin // ROLI
		 ALUSrc = 2'b01;
	  	 RegDst = 2'b01;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
              end

      	      5'b10101: begin // SLLI
		 ALUSrc = 2'b01;
	  	 RegDst = 2'b01;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
              end

    	      5'b10110: begin // RORI
		 ALUSrc = 2'b01;
	  	 RegDst = 2'b01;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
              end

     	      5'b10111: begin // SRLI
		 ALUSrc = 2'b01;
	  	 RegDst = 2'b01;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
       	      end

      	      5'b10000: begin // ST
		 ALUSrc = 2'b01;
	  	 RegDst = 2'b10;
		 AB = 5'b00011; 
	         MemWrite = 1'b1; 
		 SignExtend = 1'b1;
              end

     	      5'b10001: begin // LD
		 ALUSrc = 2'b01;
	  	 RegDst = 2'b01;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
	         MemToReg = 1'b1;
		 SignExtend = 1'b1; 
              end

      	      5'b10011: begin // STU
		 ALUSrc = 2'b01;
	  	 RegDst = 2'b10;
		 AB = 5'b00011;
	  	 RegWrite = 1'b1; 
	         MemWrite = 1'b1;
		 SignExtend = 1'b1; 
	      end

     	      5'b11001: begin // BTR
		 ALUSrc = 2'b11;
	  	 RegDst = 2'b00;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
              end

      	      5'b11011: begin // ADD, SUB, XOR, ANDN
		 ALUSrc = 2'b00;
	  	 RegDst = 2'b00;
		 AB = 5'b00011;
	  	 RegWrite = 1'b1;  
	         invA = (instr[1:0] == 2'b01) ? 1'b1 : 1'b0;
        	 invB = (instr[1:0] == 2'b11) ? 1'b1 : 1'b0;
       	 	 Cin = (instr[1:0] == 2'b01) ? 1'b1 : 1'b0;
              end

      	      5'b11010: begin // ROL, SLL, ROR, SRL
		 ALUSrc = 2'b00;
	  	 RegDst = 2'b00;
		 AB = 5'b00011;
	  	 RegWrite = 1'b1; 
       	      end

     	      5'b11100: begin // SEQ
		 ALUSrc = 2'b00;
	  	 RegDst = 2'b00;
		 AB = 5'b00011;
	  	 RegWrite = 1'b1; 
		 invB = 1'b1;
	 	 Cin = 1'b1;

              end

     	      5'b11101: begin // SLT
		 ALUSrc = 2'b00;
	  	 RegDst = 2'b00;
		 AB = 5'b00011;
	  	 RegWrite = 1'b1; 
		 invB = 1'b1;
	 	 Cin = 1'b1;
              end

     	      5'b11110: begin // SLE
		 ALUSrc = 2'b00;
	  	 RegDst = 2'b00;
		 AB = 5'b00011;
	  	 RegWrite = 1'b1;
		 invB = 1'b1;
	 	 Cin = 1'b1;
       	      end

     	      5'b11111: begin // SCO
		 ALUSrc = 2'b00;
	  	 RegDst = 2'b00;
		 AB = 5'b00011;
	  	 RegWrite = 1'b1; 
       	      end

     	      5'b01100: begin // BEQZ
	  	 RegDst = 2'b10;
	         AB = 5'b10010;
		 invB = 1'b1;
	 	 Cin = 1'b1;
              end

      	      5'b01101: begin // BNEZ
	  	 RegDst = 2'b10;
		 AB = 5'b10010;
		 invB = 1'b1;
	 	 Cin = 1'b1;

       	      end

      	      5'b01110: begin // BLTZ
	  	 RegDst = 2'b10;
	 	 AB = 5'b10010;
		 invB = 1'b1;
	 	 Cin = 1'b1;

       	      end

     	      5'b01111: begin // BGEZ
	  	 RegDst = 2'b10;
		 AB = 5'b10010;
		 invB = 1'b1;
	 	 Cin = 1'b1;
              end

      	      5'b11000: begin // LBI
		 ALUSrc = 2'b10;
	  	 RegDst = 2'b10;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1;
		 SignExtend = 1'b1; 
       	      end

     	      5'b10010: begin // SLBI
		 ALUSrc = 2'b10;
	  	 RegDst = 2'b10;
		 AB = 5'b00010;
	  	 RegWrite = 1'b1; 
              end

      	      5'b00100: begin // J
		 AB = 5'b01000;
       	      end

      	      5'b00101: begin // JR
		 AB = 5'b01010;
    	      end

     	      5'b00110: begin // JAL
		 AB = 5'b00100;
	  	 RegWrite = 1'b1;
       	      end

      	      5'b00111: begin // JALR
		 AB = 5'b00110;
	  	 RegWrite = 1'b1; 
              end

              5'b00010: begin // siic
              end

     	      5'b00011: begin // NOP / RTI
       	      end
		
	      default : begin
	      end
         endcase
       end

endmodule
		   






