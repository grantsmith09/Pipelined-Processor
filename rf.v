/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module rf (
           // Outputs
           read1data, read2data, err,
           // Inputs
           clk, rst, read1regsel, read2regsel, writeregsel, writedata, write
           );
   input clk, rst;
   input [2:0] read1regsel; // 3 bit register selector for read1data
   input [2:0] read2regsel; // 3 bit register selector for read2data
   input [2:0] writeregsel; // 3 bit register selector for writing to that register
   input [15:0] writedata; // data to be written to register
   input        write; // write enable signal. If 1 we will write the writedata to writeregsel at rising clk end.

   output [15:0] read1data; // Value of the register corresponding to read1regsel
   output [15:0] read2data; // Value of the register corresponding to read2regsel
   output        err; // err signal will assert high when we reach any state which is impossible to reach.

   
   wire [7:0] enable, decoderOut;
   wire [15:0] reg_output0, reg_output1, reg_output2, reg_output3, reg_output4, reg_output5, reg_output6, reg_output7;

   decoder3_8 dec(.in(writeregsel),.out(decoderOut));

   assign enable[0] = decoderOut[0] & write;
   assign enable[1] = decoderOut[1] & write;
   assign enable[2] = decoderOut[2] & write;
   assign enable[3] = decoderOut[3] & write;
   assign enable[4] = decoderOut[4] & write;
   assign enable[5] = decoderOut[5] & write;
   assign enable[6] = decoderOut[6] & write;
   assign enable[7] = decoderOut[7] & write;

   // 8 register instantiations
   register_16 reg0(.writedata(writedata), .write(enable[0]), .readdata(reg_output0), .clk(clk), .rst(rst));
   register_16 reg1(.writedata(writedata), .write(enable[1]), .readdata(reg_output1), .clk(clk), .rst(rst));
   register_16 reg2(.writedata(writedata), .write(enable[2]), .readdata(reg_output2), .clk(clk), .rst(rst));
   register_16 reg3(.writedata(writedata), .write(enable[3]), .readdata(reg_output3), .clk(clk), .rst(rst));
   register_16 reg4(.writedata(writedata), .write(enable[4]), .readdata(reg_output4), .clk(clk), .rst(rst));
   register_16 reg5(.writedata(writedata), .write(enable[5]), .readdata(reg_output5), .clk(clk), .rst(rst));
   register_16 reg6(.writedata(writedata), .write(enable[6]), .readdata(reg_output6), .clk(clk), .rst(rst));
   register_16 reg7(.writedata(writedata), .write(enable[7]), .readdata(reg_output7), .clk(clk), .rst(rst));


   // read1data
   mux8_1 muxread1[15:0](.in1(reg_output0), .in2(reg_output1), .in3(reg_output2), .in4(reg_output3), .in5(reg_output4), .in6(reg_output5), .in7(reg_output6), .in8(reg_output7), .sel(read1regsel), .Out(read1data));

   // read2data
   mux8_1 muxread2[15:0](.in1(reg_output0), .in2(reg_output1), .in3(reg_output2), .in4(reg_output3), .in5(reg_output4), .in6(reg_output5), .in7(reg_output6), .in8(reg_output7), .sel(read2regsel), .Out(read2data));

   assign err = 1'b0;

endmodule
