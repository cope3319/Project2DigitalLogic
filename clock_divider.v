module clock_divider #(parameter clock_divisor1 = 1, parameter clock_divisor2 = 1_000_000) (clk, /*reset_n,*/clock_out, KEY);
//parameter clock_divisor = 5_000_000; //move to top in test pass 1
input [1:0]KEY;
input clk;
//input [0]reset_n;
//input [0]clock_divider; //TB = 1 TOP = 5_000_000
output [22:0]clock_out;
reg [22:0]clock_out = 0;
reg [23:0]counter = 0;


//(clock_divider #(clock_divisor = 1); //look up parameter verilog
always @(posedge clk or negedge clk)
begin
    /*if(KEY[0] == 1'b0)
    begin
        counter = 0;
        clock_out = 0;
    end*/
    if(KEY[1] == 1'b1)
    begin
        if(counter == clock_divisor1 - 1)
        begin
            counter <= 0;
            clock_out <= ~clock_out;
        end
        else
            counter <= counter + 1;
    end
    else
    begin
        if(counter == clock_divisor2 - 1)
        begin
            counter <= 0;
            clock_out <= ~clock_out;
        end
        else
            counter <= counter + 1;
    end
end


endmodule
/*
reg [6:0]count;
reg [3:0]mod10_counter1;
reg [3:0]mod10_counter2;
always @(posedge clk or negedge reset_n)
begin
if(reset_n == 0)
begin
mod10_counter1 <= 1; // start at 1
count <= 1; //count 1 - 99
end
else if (mod10_counter1 != 9)
begin
mod10_counter <= mod10_counter + 1;
count <= count + 1;
end
else if(count == 99)
mod10_counter1 <= 0;
else
begin
mod10_counter <= 0;
count <= count + 1;
end
end

always @(posedge clk or negedge reset_n)
begin
if(reset_n == 0)
mod10_counter2 <= 0;
else if(mod10_counter1 == 9)
begin
if (mod10_counter2 != 9)
mod10_counter2 <= mod10_counter2 + 1;
else
mod10_counter2 <= 0;
end
end


endmodule

module top(ADC_CLK_10)
input ADC_CLK_10;
*/