module top(KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, ADC_CLK_10, LEDR, SW);
//clock input
input ADC_CLK_10;

//set input for KEY buttons
input [1:0] KEY; 
input [9:8] SW;
//Outputs need wires here because through the 3 blocks each hex holds 3 different values
output [7:0] HEX0; //Day2
output [7:0] HEX1; //Day1
output [7:0] HEX2; //Month 
output [7:0] HEX3; //Blank
output [7:0] HEX4; //Digit 2
output [7:0] HEX5; //Digit 1
output [1:0] LEDR;

assign HEX3[7:0] = 8'b11111111; // Make HEX3 blank
//count   
wire[3:0]day1; //This is the HEX1 number representation
wire[3:0]day2; //This is the HEX0 number representation
wire[3:0]right;
wire[3:0]left;
wire [7:0]monthSeg; //7-seg display binary represntation for the month, HEX2
reg [1:0]LEDR = 2'b01;

//Latch the button
reg reset_n = 0;
always @(negedge KEY[0])
begin
    reset_n <= ~reset_n;
    LEDR[0] = reset_n;
end


wire [22:0]clk_out;
clock_divider clock_divide(.clk(ADC_CLK_10),.clock_out(clk_out), .KEY(KEY[1:0]));

//Start Clock setup
reg [6:0]count;
reg [3:0]mod10_counter1;
reg [3:0]mod10_counter2;
//Day1
always @(posedge clk_out or negedge reset_n)
begin
    if(reset_n == 0)
    begin
        mod10_counter1 <= 1; // start at 1
        count <= 1; //count 1 - 99
    end
    else 
    begin
        LEDR[1] <= ~LEDR[1];
        if(count == 99)
        begin
        mod10_counter1 <= 1;
        count <= 1;
        end
        else 
        if (mod10_counter1 != 9)
        begin
            mod10_counter1 <= mod10_counter1 + 1;
            count <= count + 1;
        end
        else
        begin
            mod10_counter1 <= 0;
            count <= count + 1;
        end
    end
end
//Day2
always @(posedge clk_out or negedge reset_n)
begin
    if(reset_n == 0)
        mod10_counter2 <= 0;
    else if(mod10_counter1 == 9)
    begin
        if (/*mod10_counter2*/count != 100)
            mod10_counter2 <= mod10_counter2 + 1;
        else
        begin
            mod10_counter2 <= 0;
            //count = 1;
        end
    end
end
// end clock setup

// printing to 7-segment displays
monthDayCalc monthDayCalc(.data(count),.month(HEX2),.day1(day1),.day2(day2),.SW(SW[9:8]));
dualSevenSeg dualSevenSegMD(.data1(day2),.data2(day1),.display2(HEX1),.display1(HEX0));
counted counted(.count(count),.left(left),.right(right));
dualSevenSeg dualSevenSegCNT(.data1(right),.data2(left),.display2(HEX5),.display1(HEX4));



endmodule
