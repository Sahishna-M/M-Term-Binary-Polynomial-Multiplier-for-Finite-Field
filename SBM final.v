//N=6

module sbm(X,A0,A1,B0,B1,clk);
output [63:0]X;
input [31:0]A0,A1,B0,B1;
input clk;
reg [63:0]X;
always@(clk)
begin
X=((A1*B1)*1000000)+(((A1*B0)+(A0*B1))*1000)+(A0*B0);
end
endmodule
