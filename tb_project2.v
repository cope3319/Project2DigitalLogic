/* USE:
 ~from directory project2digitallogic
 ~iverilog tb_project2.v top.v segToDec.v monthDayCalc.v dualSevenSeg.v clock_divider.v counted.v
 ~vvp a.out > out.txt
 */
`timescale 1 s / 100 ns

module tb();

reg  [9:0] SW;
reg  [1:0] KEY; //Buttons
wire [7:0] HEX0; //Day2
wire [7:0] HEX1; //Day1
wire [7:0] HEX2; //Month
wire [7:0] HEX3; //should always be blank
wire [7:0] HEX4; //Digit 1
wire [7:0] HEX5; //Digit 2
wire [1:0] LEDR;

//get decimal values for each to print alongside
reg [3:0] day1digit;
reg [3:0] day2digit;
reg [3:0] monthDigit;
reg [3:0] digit1digit;
reg [3:0] digit2digit;

segToDec(.seg1(HEX1),.seg2(HEX0),.dig1(day1digit),.dig2(day2digit));
segToDec(.seg1(HEX4),.seg2(HEX5),,dig1(digit1digit),.dig2(digit2digit));

top DUT(
  .SW(SW),
  .KEY(KEY)
  .HEX0(HEX0),
  .HEX1(HEX1),
  .HEX2(HEX2),
  .HEX3(HEX3),
  .HEX4(HEX4),
  .HEX5(HEX5),
  .LEDR(LEDR)
);

initial
begin
    $dumpfile("out.vcd");
	  $dumpvars;
    $display($time, "<< Starting Simulation >>");
    
	
	$finish;
end
  
initial
  begin
    $monitor($time, " Buttons(KEY): %b, Day2(HEX0): %b, Day1(HEX1): %b, Month(HEX2): %b, Digit1(HEX4): %b, Digit2(HEX5): %b"
                              KEY[1:0],      HEX0[7:0],      HEX1[7:0],       HEX2[7:0],        HEX4[7:0],        HEX5[7:0]);
  end


endmodule