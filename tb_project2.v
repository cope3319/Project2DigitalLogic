/* USE:
 ~from directory project2digitallogic
 ~iverilog tb_project2.v top.v segToDec.v monthDayCalc.v dualSevenSeg.v clock_divider.v counted.v
 ~vvp a.out > out.txt
 */
`timescale 1 ns / 100 ps

module tb();

reg  [9:8] SW;
reg  [1:0] KEY; //Buttons
wire [7:0] HEX0; //Day2
wire [7:0] HEX1; //Day1
wire [7:0] HEX2; //Month
wire [7:0] HEX3; //should always be blank
wire [7:0] HEX4; //Digit 1
wire [7:0] HEX5; //Digit 2
wire [1:0] LEDR;

wire [3:0]day1; //This is the HEX1 number representation
wire [3:0]day2; //This is the HEX0 number representation
wire [3:0]right;
wire [3:0]left; 

/*
//get decimal values for each to print alongside
reg [3:0] day1digit;
reg [3:0] day2;
reg [3:0] monthDigit;
reg [3:0] unusedMonthDig;
reg [3:0] digit1digit;
reg [3:0] digit2digit;

segToDec(.seg1(HEX1),.seg2(HEX0),.dig1(day1digit),.dig2(day2));
segToDec(.seg1(HEX4),.seg2(HEX5),,dig1(digit1digit),.dig2(digit2digit));
segToDec(.seg1(HEX3),.seg2(HEX2),.dig1(unusedMonthDig),.dig2(monthDigit));
*/

top DUT(
  .SW(SW),
  .KEY(KEY),
  .HEX0(HEX0),
  .HEX1(HEX1),
  .HEX2(HEX2),
  .HEX3(HEX3),
  .HEX4(HEX4),
  .HEX5(HEX5),
  .LEDR(LEDR),
  .day1(day1),
  .day2(day2),
  .right(right),
  .left(left)
);

initial
begin
    $dumpfile("out.vcd");
	$dumpvars;
    $display($time, " << Starting Simulation >>");
    SW[9:8] = 2'b00;
    KEY[1:0] = 2'b11;
    $display($time, " SW[9] low: %b, no buttons KEY[1:0]= = %b",SW[9],KEY[1:0]);
    $dumpvars;
    KEY[0] = 1'b0;
    $display($time, " Pressing reset to begin, KEY[0] = %b, HEX2 Cleared: %b",KEY[0],HEX2[7:0]);
    #1000
    $display($time, " Left Digit: HEX5 = %b, Right Digit: HEX4 = %b", HEX5[7:0], HEX4[7:0]);
    $display($time, " Left Day: HEX1 = %b, Right Day: HEX0 = %b, Month: HEX2 = %b",HEX1[7:0],HEX0[7:0],HEX2[7:0]);
    $display($time, " Converted to digits: %b %b - %b - %b %b",
                    digit2digit[3:0],digit1digit[3:0],monthDigit[3:0],day1[3:0],day2[3:0]);
    /*repeat(100) begin
        if($time == 1000) KEY[0] = 1'b1; //unpressing button after first second
        $display($time, " Left Digit: HEX5 = %b, Right Digit: HEX4 = %b", HEX5[7:0], HEX4[7:0]);
        $display($time, " Left Day: HEX1 = %b, Right Day: HEX0 = %b, Month: HEX2 = %b",HEX1[7:0],HEX0[7:0],HEX2[7:0]);
        $display($time, " Converted to digits: %b %b - %b %b - %b %b",
                          digit2digit[3:0],digit1digit[3:0],unusedMonthDig[3:0],monthDigit[3:0],day1[3:0],day2[3:0]);
        #1000
    end*/
    $display($time, " Ending Simulation, Connor Peskin");
	$finish;
end
  
initial
begin
      $monitor($time, " Buttons(KEY): %b, Day2(HEX0): %b, Day1(HEX1): %b, Month(HEX2): %b, Digit1(HEX4): %b, Digit2(HEX5): %b",
                              KEY[1:0],      HEX0[7:0],      HEX1[7:0],       HEX2[7:0],        HEX4[7:0],        HEX5[7:0]);
end


endmodule