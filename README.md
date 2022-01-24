# Pipelined-Processor
Moving on to the next part of the project now you will implement a 5 stage pipelined architecture
for WISC-SP13 ISA. As already discussed in the class the 5 staged pipelined design helps us
improve the performance by improving the cycle time. Unlike unpipelined implementation, you
will not have a CPI of 1, but the CPI will be greater than 1 due to hazards. Have fun
implementing the design.

#Memory
Same as the unpipelined design you will also use 2 separate memories in this design. The first
is for instruction fetch and the second is for data memory. Your memories will be single-cycle
perfect memories. You will use the same memory2c.v that you used in the unpipelined design.
You should instantiate it twice, once for instruction memory and the other for the data memory
(as you did earlier).

#5 Staged Design
The design that you will make will be a 5 stages design similar to the one discussed in the class.
So your design will have IF→ID→EX→MEM→WB.

#Pipeline Hazards
For the pipelined design you must implement hazard detection to detect the hazards. You also
need to implement 2 types of data forwarding which are EX/MEM and EX/WB. As for the other
possible data forwarding (like MEM/WB), you can decide whether to implement them or just add
a stall.

Lastly, for the branches, you can decide whether to use stalls or make a branch predictor. You
can make a simple branch predictor where you always assume not taken branch and when you
find that the prediction was wrong you invalidate the older instructions in the pipeline which are
incorrect. (by not taken branch I mean nextPC = PC + 2)
