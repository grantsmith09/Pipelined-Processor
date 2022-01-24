module mux8_1(Out, in1, in2, in3, in4, in5, in6, in7, in8, sel);

	input in1, in2, in3, in4, in5, in6, in7, in8;
	input [2:0] sel;
	output Out;

	wire temp1, temp2;

	mux4_1 mux1(.Out(temp1), .in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel[1:0]));
	mux4_1 mux2(.Out(temp2), .in1(in5), .in2(in6), .in3(in7), .in4(in8), .sel(sel[1:0]));
	mux2_1 mux3(.Out(Out), .in1(temp1), .in2(temp2), .sel(sel[2]));

endmodule 
