module counted(count, left, right);
input [6:0]count;
output [3:0]right;
output [3:0]left;
reg [3:0]left;
reg [3:0]right;
always @*
begin
right = (count %10);
left = (count /10);
end
endmodule