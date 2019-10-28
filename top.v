module top(KEY, HEX0, HEX1, HEX2, HEX4, HEX5)

//set input for KEY buttons
input [1:0] KEY; 

//Outputs need wires here because through the 3 blocks each hex holds 3 different values
output [7:0] HEX0; //Day2
output [7:0] HEX1; //Day1
output [7:0] HEX2; //Month 
output [7:0] HEX4; //Digit 2
output [7:0] HEX5; //Digit 1

reg [6:0]numTotal; //This is the number that is currently being displayed, like 99
reg [3:0]day1; //This is the HEX1 number representation
reg [3:0]day2; //This is the HEX0 number representation
wire [7:0]monthSeg; //7-seg display binary represntation for the month, HEX2

//This is kinda how were going to want to use monthDayCalc.v, but definetely change it to make it work for you
always @*
begin
    monthDayCalc monthDayCalc(.data(numTotal),.month(HEX2),.day1(day1),.day2(day2));
    dualSevenSeg dualSevenSeg(.data1(day2),.data2(day1),.display2(HEX1),.display1(HEX0));
end


endmodule
