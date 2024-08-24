//64 bit rca
module rca64bit(sum,carry,cin,a,b);
output [63:0]sum;
output carry;
input [63:0]a,b;
input cin;
wire c1,c2,c3;

rca16bit rca1(.a(a[15:0]),.b(b[15:0]),.cin(cin),.sum(sum[15:0]),.carry(c1));
rca16bit rca2(.a(a[31:16]),.b(b[31:16]),.cin(c1),.sum(sum[31:16]),.carry(c2));
rca16bit rca3(.a(a[47:32]),.b(b[47:32]),.cin(c2),.sum(sum[47:32]),.carry(c3));
rca16bit rca4(.a(a[63:48]),.b(b[63:48]),.cin(c3),.sum(sum[63:48]),.carry(carry));
endmodule

//16 bit rca
module rca16bit(sum,carry,cin,a,b);
output [15:0]sum;
output carry;
input [15:0]a,b;
input cin;
wire c1,c2,c3;

rca4bit rca4bit1(.a(a[3:0]),.b(b[3:0]),.cin(cin),.sum(sum[3:0]),.carry(c1));

rca4bit rca4bit2(.a(a[7:4]),.b(b[7:4]),.cin(c1),.sum(sum[7:4]),.carry(c2));

rca4bit rca4bit3(.a(a[11:8]),.b(b[11:8]),.cin(c2),.sum(sum[11:8]),.carry(c3));

rca4bit rca4bit4(.a(a[15:12]),.b(b[15:12]),.cin(c3),.sum(sum[15:12]),.carry(carry));
endmodule

//4 bit rca
module rca4bit(sum,carry,cin,a,b);
output [3:0]sum;
output carry;
input [3:0]a,b;
input cin;
wire c1,c2,c3;

fulladder fa1(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.carry(c1));

fulladder fa2(.a(a[1]),.b(b[1]),.cin(c1),.sum(sum[1]),.carry(c2));

fulladder fa3(.a(a[2]),.b(b[2]),.cin(c2),.sum(sum[2]),.carry(c3));

fulladder fa4(.a(a[3]),.b(b[3]),.cin(c3),.sum(sum[3]),.carry(carry));
endmodule

//fulladder
module fulladder(sum,carry,cin,a,b);
output sum,carry;
input cin,a,b;
wire x,y,z;
halfadder ha1(.a(a),.b(b),.sum(x),.carry(y));
halfadder ha2(.a(x),.b(cin),.sum(sum),.carry(z));
or o1(carry,y,z);
endmodule

//halfadder
module halfadder(sum,carry,a,b);
output sum,carry;
input a,b;
xor x1(sum,a,b);
and a1(carry,a,b);
endmodule

