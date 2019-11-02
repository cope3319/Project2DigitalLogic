/* USE:
 ~from directory project2digitallogic
 ~iverilog tb_project2.v top.v monthDayCalc.v dualSevenSeg.v clock_divider.v counted.v
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
    $monitor($time, " Input1(SW[7:4]): %b, Input2(SW[3:0]): %b, SW[8]: %b, HEX5: %b, HEX4: %b, HEX1: %b, HEX0: %b",
                             SW[7:4],             SW[3:0],      SW[8],     HEX5,     HEX4,     HEX1,     HEX0);
  end


endmodule