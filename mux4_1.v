module mux4_1(Out, in1, in2, in3, in4, sel);

	input in1, in2, in3, in4; 
	input [1:0] sel;
	output Out;
	
	wire temp1, temp2; 

        mux2_1 mux1(.Out(temp1), .in1(in1), .in2(in2), .sel(sel[0]));
	mux2_1 mux2(.Out(temp2), .in1(in3), .in2(in4), .sel(sel[0]));
	mux2_1 mux3(.Out(Out), .in1(temp1), .in2(temp2), .sel(sel[1]));

endmodule
