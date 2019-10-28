module monthDayCalc(data,month,day1,day2)
//input number of the day of the year, outputs the month and day
// day1 is leftmost 7-seg (Overflow bit) , day2 is rightmost 7-seg
input [6:0] data;
output [7:0] month;
output [3:0] day1;
output [3:0] day2;
reg [6:0] dayData;

always @* //sending out month 7-segment binary value
begin
   if(data>=7'd89)  
    month = 8'b10011001; //4 - April
   else if(data>=7'd59)  
    month = 8'b10110000; //3 - March
   else if(data>=7'd31)
    month = 8'b10100100; //2 - February
   else
    month = 8'b11111001; //1 - January
end
always @* //Get the date of the month
begin
   if(data>=7'd89)  
    dayData = (data%7'b89); //4 - Aprl
   else if(data>=7'd59)  
    dayData = (data%7'b89); //3 - March
   else if(data>=7'd31)
    dayData = (data%7'b89); //2 - February
   else
    dayData = data;         //1 - January
end



endmodule