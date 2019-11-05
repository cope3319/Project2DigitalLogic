/* USE:
 ~from directory project2digitallogic/
 ~iverilog tb_project2.v top.v monthDayCalc.v dualSevenSeg.v clock_divider.v counted.v
 ~vvp a.out > out.txt
 */
`timescale 1 ms / 100 ps

module tb();

reg ADC_CLK_10;
reg  [9:8] SW;
reg  [1:0] KEY; //Buttons
wire [7:0] HEX0; //Day2
wire [7:0] HEX1; //Day1
wire [7:0] HEX2; //Month
wire [7:0] HEX3; //should always be blank
wire [7:0] HEX4; //Digit 1
wire [7:0] HEX5; //Digit 2
wire [1:0] LEDR;

reg [3:0] day1digit;
reg [3:0] day2digit;
reg [3:0] monthDigit;
reg [3:0] unusedMonthDig;
reg [3:0] digit1digit;
reg [3:0] digit2digit;

always #1 ADC_CLK_10 = ~ADC_CLK_10; //will be a 500Hz clk

top #(250,50) DUT(
  .KEY(KEY),
  .HEX0(HEX0),
  .HEX1(HEX1),
  .HEX2(HEX2),
  .HEX3(HEX3),
  .HEX4(HEX4),
  .HEX5(HEX5),
  .ADC_CLK_10(ADC_CLK_10),
  .LEDR(LEDR),
  .SW(SW)  
);

initial
begin
    $dumpfile("out.vcd");
	$dumpvars;
    $display($time, " << Starting Simulation >>");
    ADC_CLK_10 = 1'b1;
    SW[9:8] = 2'b00;
    KEY[1:0] = 2'b11;
    $display($time, " SW[9] low: %b, no buttons KEY[1:0]= %b",SW[9],KEY[1:0]);
    #1000 
    KEY[1:0] = 2'b10;
    #250
    $display($time, " Pressing reset to begin, KEY[0] = %b, HEX3 Cleared: %b",KEY[0],HEX3[7:0]);
    $display($time, " Left Digit: HEX5 = %b, Right Digit: HEX4 = %b", HEX5[7:0], HEX4[7:0]);
    $display($time, " Left Day: HEX1 = %b, Right Day: HEX0 = %b, Month: HEX2 = %b",HEX1[7:0],HEX0[7:0],HEX2[7:0]);
    $display($time," Converted to digits: %d %d - %d %d - %d %d",
                digit2digit[3:0],digit1digit[3:0],unusedMonthDig[3:0], monthDigit[3:0],day1digit[3:0],day2digit[3:0]);
    repeat(98) begin
        #1000
        $display($time, " Left Digit: HEX5 = %b, Right Digit: HEX4 = %b", HEX5[7:0], HEX4[7:0]);
        $display($time, " Left Day: HEX1 = %b, Right Day: HEX0 = %b, Month: HEX2 = %b",HEX1[7:0],HEX0[7:0],HEX2[7:0]);
        $display($time," Converted to digits: %d %d - %d %d - %d %d",
                   digit2digit[3:0],digit1digit[3:0],unusedMonthDig[3:0], monthDigit[3:0],day1digit[3:0],day2digit[3:0]);
        
    end
    SW[9] = 1'b1;
    $display($time, " Now turning on leap year-> SW[9]=%b",SW[9]);
    KEY[1:0] = 2'b10;
    #250
    $display($time, " Left Digit: HEX5 = %b, Right Digit: HEX4 = %b", HEX5[7:0], HEX4[7:0]);
    $display($time, " Left Day: HEX1 = %b, Right Day: HEX0 = %b, Month: HEX2 = %b",HEX1[7:0],HEX0[7:0],HEX2[7:0]);
    $display($time," Converted to digits: %d %d - %d %d - %d %d",
                digit2digit[3:0],digit1digit[3:0],unusedMonthDig[3:0], monthDigit[3:0],day1digit[3:0],day2digit[3:0]);
    KEY[1:0] = 2'b11;
    repeat(98) begin
        #1000
        $display($time, " Left Digit: HEX5 = %b, Right Digit: HEX4 = %b", HEX5[7:0], HEX4[7:0]);
        $display($time, " Left Day: HEX1 = %b, Right Day: HEX0 = %b, Month: HEX2 = %b",HEX1[7:0],HEX0[7:0],HEX2[7:0]);
        $display($time," Converted to digits: %d %d - %d %d - %d %d",
                   digit2digit[3:0],digit1digit[3:0],unusedMonthDig[3:0], monthDigit[3:0],day1digit[3:0],day2digit[3:0]);
    end
    KEY[0] = 1'b0;
    #250
    KEY[0] = 1'b1;
    #250 
    KEY[1:0] = 2'b00;
    $display($time, " Now pressing KEY[1]: %b",KEY[1]);
    #1000
    $display($time, " Left Digit: HEX5 = %b, Right Digit: HEX4 = %b", HEX5[7:0], HEX4[7:0]);
    $display($time, " Left Day: HEX1 = %b, Right Day: HEX0 = %b, Month: HEX2 = %b",HEX1[7:0],HEX0[7:0],HEX2[7:0]);
    $display($time," Converted to digits: %d %d - %d %d - %d %d",
                digit2digit[3:0],digit1digit[3:0],unusedMonthDig[3:0], monthDigit[3:0],day1digit[3:0],day2digit[3:0]);
    KEY[0] = 1'b1;
    repeat(98) begin
        #500
        $display($time, " Left Digit: HEX5 = %b, Right Digit: HEX4 = %b", HEX5[7:0], HEX4[7:0]);
        $display($time, " Left Day: HEX1 = %b, Right Day: HEX0 = %b, Month: HEX2 = %b",HEX1[7:0],HEX0[7:0],HEX2[7:0]);
        $display($time," Converted to digits: %d %d - %d %d - %d %d",
                   digit2digit[3:0],digit1digit[3:0],unusedMonthDig[3:0], monthDigit[3:0],day1digit[3:0],day2digit[3:0]);
    end
    
    $display($time, " Ending Simulation, by Connor Peskin");
	$finish;
end

initial
begin
      $monitor($time, " Buttons(KEY): %b, Day2(HEX0): %b, Day1(HEX1): %b, UnusedMonth(HEX3): %b, Month(HEX2): %b, Digit1(HEX4): %b, Digit2(HEX5): %b",
                              KEY[1:0],      HEX0[7:0],      HEX1[7:0],               HEX3[7:0], HEX2[7:0],        HEX4[7:0],        HEX5[7:0]);
end


always @* 
begin
    casex(HEX1[7:0])
        8'b11111111 : day1digit = 4'b0000; //0
        8'b11111001 : day1digit = 4'b0001; //1
        8'b10100100 : day1digit = 4'b0010; //2
        8'b10110000 : day1digit = 4'b0011; //3
        8'b10011001 : day1digit = 4'b0100; //4
        8'b10010010 : day1digit = 4'b0101; //5
        8'b10000010 : day1digit = 4'b0110; //6
        8'b11111000 : day1digit = 4'b0111; //7
        8'b10000000 : day1digit = 4'b1000; //8
        8'b10010000 : day1digit = 4'b1001; //9
    endcase
    casex(HEX0[7:0])
        8'b11000000 : day2digit = 4'b0000; //0
        8'b11111001 : day2digit = 4'b0001; //1
        8'b10100100 : day2digit = 4'b0010; //2
        8'b10110000 : day2digit = 4'b0011; //3
        8'b10011001 : day2digit = 4'b0100; //4
        8'b10010010 : day2digit = 4'b0101; //5
        8'b10000010 : day2digit = 4'b0110; //6
        8'b11111000 : day2digit = 4'b0111; //7
        8'b10000000 : day2digit = 4'b1000; //8
        8'b10010000 : day2digit = 4'b1001; //9
    endcase
    casex(HEX2[7:0])
        8'b11000000 : monthDigit = 4'b0000; //0
        8'b11111001 : monthDigit = 4'b0001; //1
        8'b10100100 : monthDigit = 4'b0010; //2
        8'b10110000 : monthDigit = 4'b0011; //3
        8'b10011001 : monthDigit = 4'b0100; //4
        8'b10010010 : monthDigit = 4'b0101; //5
        8'b10000010 : monthDigit = 4'b0110; //6
        8'b11111000 : monthDigit = 4'b0111; //7
        8'b10000000 : monthDigit = 4'b1000; //8
        8'b10010000 : monthDigit = 4'b1001; //9
    endcase
    casex(HEX3[7:0])
        8'b11000000 : unusedMonthDig = 4'b0000; //0
        8'b11111001 : unusedMonthDig = 4'b0001; //1
        8'b10100100 : unusedMonthDig = 4'b0010; //2
        8'b10110000 : unusedMonthDig = 4'b0011; //3
        8'b10011001 : unusedMonthDig = 4'b0100; //4
        8'b10010010 : unusedMonthDig = 4'b0101; //5
        8'b10000010 : unusedMonthDig = 4'b0110; //6
        8'b11111000 : unusedMonthDig = 4'b0111; //7
        8'b10000000 : unusedMonthDig = 4'b1000; //8
        8'b10010000 : unusedMonthDig = 4'b1001; //9
        8'b11111111 : unusedMonthDig = 4'b0000; //0
    endcase
    casex(HEX4[7:0])
        8'b11111111 : digit1digit = 4'b0000; //0
        8'b11111001 : digit1digit = 4'b0001; //1
        8'b10100100 : digit1digit = 4'b0010; //2
        8'b10110000 : digit1digit = 4'b0011; //3
        8'b10011001 : digit1digit = 4'b0100; //4
        8'b10010010 : digit1digit = 4'b0101; //5
        8'b10000010 : digit1digit = 4'b0110; //6
        8'b11111000 : digit1digit = 4'b0111; //7
        8'b10000000 : digit1digit = 4'b1000; //8
        8'b10010000 : digit1digit = 4'b1001; //9
    endcase
    casex(HEX5[7:0])
        8'b11000000 : digit2digit = 4'b0000; //0
        8'b11111001 : digit2digit = 4'b0001; //1
        8'b10100100 : digit2digit = 4'b0010; //2
        8'b10110000 : digit2digit = 4'b0011; //3
        8'b10011001 : digit2digit = 4'b0100; //4
        8'b10010010 : digit2digit = 4'b0101; //5
        8'b10000010 : digit2digit = 4'b0110; //6
        8'b11111000 : digit2digit = 4'b0111; //7
        8'b10000000 : digit2digit = 4'b1000; //8
        8'b10010000 : digit2digit = 4'b1001; //9
    endcase
end



endmodule