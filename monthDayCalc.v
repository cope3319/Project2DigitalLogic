module monthDayCalc(data,month,day1,day2)
//input number of the day of the year, outputs the month and day
// day1 is leftmost 7-seg (Overflow bit) , day2 is rightmost 7-seg
input [6:0] data;
output [4:0] month;
output [7:0] day1;
output [7:0] day2;
reg [7:0] day1;
reg [7:0] day2;

endmodule