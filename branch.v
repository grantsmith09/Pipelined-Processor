module branch(Zero, Pos, Neg, opcode, branchsel);

   input [4:0] opcode;
   input Zero, Pos, Neg;

   output reg branchsel;

   
   always @(*) begin 

      case(opcode)

	 default : begin
	    branchsel = 1'b0;
	 end

         5'b01100: begin // BEQZ
            branchsel = (Zero) ? 1'b1 : 1'b0;
         end

	 5'b01101: begin // BNEZ
            branchsel = (Neg|Pos) ? 1'b1 : 1'b0;
         end

	 5'b01110: begin // BLTZ
            branchsel = (Neg) ? 1'b1 : 1'b0;
         end

 	 5'b01111: begin // BGEZ
            branchsel = (Zero|Pos) ? 1'b1 : 1'b0;
         end

      endcase
   end
endmodule
