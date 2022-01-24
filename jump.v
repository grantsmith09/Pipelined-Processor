module jump(opcode, JMP, JR, JAL);
   
   input [4:0] opcode;
  
   output reg JMP, JR, JAL;

   always @(*) begin 

      case(opcode)

	 default : begin
	    JMP = 1'b0; 
	    JR = 1'b0;
	    JAL = 1'b0;
	 end

         5'b00100: begin // J
            JMP = 1'b1; 
	    JR = 1'b0;
	    JAL = 1'b0;
         end

	 5'b00101: begin // JR
            JMP = 1'b0; 
	    JR = 1'b1;
	    JAL = 1'b0;
         end

	 5'b00110: begin // JAL
            JMP = 1'b1; 
	    JR = 1'b0;
	    JAL = 1'b1;
         end

 	 5'b00111: begin // JALR
            JMP = 1'b0; 
	    JR = 1'b1;
	    JAL = 1'b1;
         end

      endcase
   end
endmodule
