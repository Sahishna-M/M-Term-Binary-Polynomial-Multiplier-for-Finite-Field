//N=8 composite multiplier
//a=12001300
//b=14001002
module compositel1(Comp_RCA_L1,k1,k2,k3);
output [63:0]Comp_RCA_L1,k1,k2,k3;
wire [63:0]g1,g2;
wire [63:0]sum1,sum2;
wire carry1,carry2;
assign k1=1200*1400;
assign k2=1300*1002;
assign k3=2500*2402;
assign g1=k1*100000000;
assign g2=(k3-k2-k1)*10000;
rca64bit r1(.sum(sum1),.carry(carry1),.cin(1'd0),.a(g1),.b(g2));
rca64bit r2(.sum(sum2),.carry(carry2),.cin(carry1),.a(sum1),.b(k2));
assign Comp_RCA_L1= {carry2,sum2};
endmodule

 

module compositel2(Comp_RCA_L2,k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33);
output [63:0]Comp_RCA_L2,k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33;
wire [63:0]g3,g4;
wire [63:0]sum3,sum4;
wire carry3,carry4;
assign k11=12*14;
assign k12=0*0;
assign k13=12*14;
assign k1=(10000*k11)+(100*(k13-k12-k11))+k12;
assign k21=13*10;
assign k22=0*2;
assign k23=13*12;
assign k2=(10000*k21)+(100*(k23-k22-k21))+k22;
assign k31=25*24;
assign k32=0*2;
assign k33=25*26;
assign k3=(10000*k31)+(100*(k33-k32-k31))+k32;
assign g3=100000000*k1;
assign g4=10000*(k3-k2-k1);
rca64bit r3(.sum(sum3),.carry(carry3),.cin(1'd0),.a(g3),.b(g4));
rca64bit r4(.sum(sum4),.carry(carry4),.cin(carry3),.a(sum3),.b(k2));
assign Comp_RCA_L2={carry4,sum4};
endmodule

 

module compositel3(Comp_RCA_L3,k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33,k111,k112,k113,k121,k122,k123,k131,k132,k133,k211,k212,k213,k221,k222,k223,k231,k232,k233,k311,k312,k313,k321,k322,k323,k331,k332,k333);
output [63:0]Comp_RCA_L3,k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33,k111,k112,k113,k121,k122,k123,k131,k132,k133,k211,k212,k213,k221,k222,k223,k231,k232,k233,k311,k312,k313,k321,k322,k323,k331,k332,k333;
wire [63:0]g5,g6;
wire [63:0]sum5,sum6;
wire carry5,carry6;
assign k111=1*1;
assign k112=4*2;
assign k113=3*5;
assign k11=(100*k111)+(10*(k113-k112-k111))+k112;
assign k121=0;
assign k122=0;
assign k123=0;
assign k12=(100*k121)+(10*(k123-k122-k121))+k122;
assign k131=1*1;
assign k132=2*4;
assign k133=3*5;
assign k13=(k131*100)+((k133-k132-k131)*10)+k132;
assign k1=(10000*k11)+(100*(k13-k12-k11))+k12;
assign k211=1*1;
assign k212=3*0;
assign k213=4*1;
assign k21=(k211*100)+((k213-k212-k211)*10)+k212;
assign k221=0*0;
assign k222=0*2;
assign k223=0*2;
assign k22=(k221*100)+((k223-k222-k221)*10)+k222;
assign k231=1*1;
assign k232=3*2;
assign k233=4*3;
assign k23=(k231*100)+((k233-k232-k231)*10)+k232;
assign k2=(k21*10000)+((k23-k22-k21)*100)+k22;
assign k311=2*2;
assign k312=5*4;
assign k313=7*6;
assign k31=(k311*100)+((k313-k312-k311)*10)+k312;
assign k321=0*0;
assign k322=0*2;
assign k323=0*2;
assign k32=(k321*100)+((k323-k322-k321)*10)+k322;
assign k331=2*2;
assign k332=5*6;
assign k333=7*8;
assign k33=(k331*100)+((k333-k332-k331)*10)+k332;
assign k3=(k31*10000)+((k33-k32-k31)*100)+k32;
assign g5=k1*100000000;
assign g6=(k3-k2-k1)*10000;
rca64bit r5(.sum(sum5),.carry(carry5),.cin(1'd0),.a(g5),.b(g6));
rca64bit r6(.sum(sum6),.carry(carry6),.cin(carry5),.a(sum5),.b(k2));
assign Comp_RCA_L3={carry6,sum6};
endmodule

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

