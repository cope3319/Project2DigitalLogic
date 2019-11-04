module monthDayCalc(data,month,day1,day2,SW);
//input number of the day of the year, outputs the month and day
// day1 is leftmost 7-seg (Overflow bit) , day2 is rightmost 7-seg
input [6:0] data;
output [7:0] month;//count
output [3:0] day1;//mod1
output [3:0] day2;//mod2
reg [7:0] dayData;//should be 7:0 not six 8 bit total
reg [7:0] month;
reg [3:0] day1;
reg [3:0] day2;


input [9:8]SW;


always @* //sending out month 7-segment binary value
begin
if(SW[9] == 1'b1)//leap year
begin
   if(data>=7'd92)  
    month = 8'b10011001; //4 - April
   else if(data>=7'd61)  
    month = 8'b10110000; //3 - March
   else if(data>=7'd32)
    month = 8'b10100100; //2 - February
   else
    month = 8'b11111001; //1 - January
end
else 
begin
   if(data>=7'd91)  
    month = 8'b10011001; //4 - April
   else if(data>=7'd60)  
    month = 8'b10110000; //3 - March
   else if(data>=7'd32)
    month = 8'b10100100; //2 - February
   else
    month = 8'b11111001; //1 - January
end
end

always @* //Get the date of the month
begin
if(SW[9] == 1'b1) //leap year
begin
   if(data>=7'd92)  
    dayData = (data % 7'd91); //4 - Aprl
   else if(data>=7'd61)  
    dayData = (data % 7'd60); //3 - March
   else if(data>=7'd32)
    dayData = (data % 7'd31); //2 - February
   else
    dayData = data;         //1 - January
end
else
begin
   if(data>=7'd91)  
    dayData = (data % 7'd90); //4 - Aprl
   else if(data>=7'd60)  
    dayData = (data % 7'd59); //3 - March
   else if(data>=7'd32)
    dayData = (data % 7'd31); //2 - February
   else
    dayData = data;         //1 - January
end
end

always @*
begin
    day2 = (dayData%10); //rightmost bit
    day1 = (dayData/10); //overflow left bit
end


endmodule