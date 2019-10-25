module top(KEY, HEX0, HEX1, HEX2, HEX4, HEX5)

//set input for KEY buttons
input [1:0] KEY; 

//Outputs need wires here because through the 3 blocks each hex holds 3 different values
output [7:0] HEX0; 
output [7:0] HEX1;
output [7:0] HEX2;
output [7:0] HEX3;
output [7:0] HEX4;
output [7:0] HEX5;

endmodule
