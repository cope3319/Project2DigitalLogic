module dualSevenSeg(data1,data2,display2,display1);
//this module will print to two 7-segment display's at the same time.
input [3:0]data1;
input [3:0]data2;
output [7:0] display1;
output [7:0] display2;
reg [7:0]display1;
reg [7:0]display2;

always @* //right-most digit, display1
begin
    casex (data1[3:0])
        4'b0000 : display1 = 8'b11000000; //0
        4'b0001 : display1 = 8'b11111001; //1
        4'b0010 : display1 = 8'b10100100; //2
        4'b0011 : display1 = 8'b10110000; //3
        4'b0100 : display1 = 8'b10011001; //4
        4'b0101 : display1 = 8'b10010010; //5
        4'b0110 : display1 = 8'b10000010; //6
        4'b0111 : display1 = 8'b11111000; //7
        4'b1000 : display1 = 8'b10000000; //8
        4'b1001 : display1 = 8'b10010000; //9
    endcase
end
always @*
begin
    casex (data2[3:0])
        4'b0000 : display2 = 8'b11111111; //blank
        4'b0001 : display2 = 8'b11111001; //1
        4'b0010 : display2 = 8'b10100100; //2
        4'b0011 : display2 = 8'b10110000; //3
        4'b0100 : display2 = 8'b10011001; //4
        4'b0101 : display2 = 8'b10010010; //5
        4'b0110 : display2 = 8'b10000010; //6
        4'b0111 : display2 = 8'b11111000; //7
        4'b1000 : display2 = 8'b10000000; //8
        4'b1001 : display2 = 8'b10010000; //9
    endcase
end
endmodule
