// COMPOSITE WITH KOGGE STONE AND COUNTER

//a=12001300
//b=14001002
//output= 168030225302600
module compcounterl1(Comp_Kogge_Counter_L1,g1,g2,g3);
output [63:0]Comp_Kogge_Counter_L1,g1,g2,g3;
wire [63:0]k1,k2,k3;
wire [63:0]sum1,sum2;
wire carry1,carry2;
assign k1=1200*1400;
assign k2=1300*1002;
assign k3=2500*2402;
assign g1=k1*100000000;
assign g2=(k3-k2-k1)*10000;
assign g3=k2;
kogge64bit r1(.sum(sum1),.carry(carry1),.cin(1'd0),.a(g1),.b(g2));
kogge64bit r2(.sum(sum2),.carry(carry2),.cin(carry1),.a(sum1),.b(g3));
assign Comp_Kogge_Counter_L1= {carry2,sum2};
endmodule

 

module compcounterl2(Comp_Kogge_Counter_L2,k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33);
output [63:0]Comp_Kogge_Counter_L2,k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33;
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
kogge64bit r3(.sum(sum3),.carry(carry3),.cin(1'd0),.a(g3),.b(g4));
kogge64bit r4(.sum(sum4),.carry(carry4),.cin(carry3),.a(sum3),.b(k2));
assign Comp_Kogge_Counter_L2={carry4,sum4};
endmodule

 

module compcounterl3(Comp_Kogge_Counter_L3,k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33,k111,k112,k113,k121,k122,k123,k131,k132,k133,k211,k212,k213,k221,k222,k223,k231,k232,k233,k311,k312,k313,k321,k322,k323,k331,k332,k333);
output [63:0]Comp_Kogge_Counter_L3,k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33,k111,k112,k113,k121,k122,k123,k131,k132,k133,k211,k212,k213,k221,k222,k223,k231,k232,k233,k311,k312,k313,k321,k322,k323,k331,k332,k333;
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
kogge64bit r5(.sum(sum5),.carry(carry5),.cin(1'd0),.a(g5),.b(g6));
kogge64bit r6(.sum(sum6),.carry(carry6),.cin(carry5),.a(sum5),.b(k2));
assign Comp_Kogge_Counter_L3={carry6,sum6};
endmodule

//64 bit kogge stone adder

module kogge64bit(sum, carry, cin, a, b);
input [63:0]a,b;
input cin;
output [64:0]sum;
output carry;
wire c1,c2,c3;
wire [63:0]s;

kogge16bit kogge1(.a(a[15:0]),.b(b[15:0]),.cin(cin),.sum(s[15:0]),.carry(c1));
kogge16bit kogge2(.a(a[31:16]),.b(b[31:16]),.cin(c1),.sum(s[31:16]),.carry(c2));
kogge16bit kogge3(.a(a[47:32]),.b(b[47:32]),.cin(c2),.sum(s[47:32]),.carry(c3));
kogge16bit kogge4(.a(a[63:48]),.b(b[63:48]),.cin(c3),.sum(s[63:48]),.carry(carry));
assign sum={carry,s};
endmodule

//16 bit kogge
module kogge16bit(final,sum,carry,cin,a,b);
output [16:0]final;
output carry;
input [15:0]a,b;
input cin;
wire c1,c2,c3;
wire [15:0]s;
output [15:0]sum;

kogge4bit kogge4bit1(.a(a[3:0]),.b(b[3:0]),.cin(cin),.sum(s[3:0]),.carry(c1));

kogge4bit kogge4bit2(.a(a[7:4]),.b(b[7:4]),.cin(c1),.sum(s[7:4]),.carry(c2));

kogge4bit koggebit3(.a(a[11:8]),.b(b[11:8]),.cin(c2),.sum(s[11:8]),.carry(c3));

kogge4bit kogge4bit4(.a(a[15:12]),.b(b[15:12]),.cin(c3),.sum(s[15:12]),.carry(carry));

assign sum=s;
assign final={carry,sum};
endmodule

//4 bit kogge

module kogge4bit(final, sum, carry, cin, a, b);
input [3:0]a,b;
input cin;
output [4:0] final;
output [3:0]sum;
output carry;
reg g0a,g0b,g0c,p00,g00,c0,s0,p10,g10,g11,c1,s1,p20,g20,p21,g21,g22,c2,s2,p30,g30,p31,g31,g32,c3,s3;

always@(*)
begin

// 0th bit
g0a=a[0]&cin;
g0b=b[0]&cin;
g0c=a[0]&b[0];

p00=a[0]^b[0];
g00=g0a|g0b|g0c;

if(a[0]== 0 && b[0]==0 && cin==0)
begin
c0=0;
s0=0;
end
else
begin
c0=g00;
s0=p00^cin;
end

//1st bit
p10=a[1]^b[1];
g10=a[1]&b[1];
g11=g10|(p10&g00);
if(a[1]== 0 && b[1]==0 && c0==0)
begin
c1=0;
s1=0;
end
else
begin
c1=g11;
s1=p10^g00;
end

//2nd bit
p20=a[2]^b[2];
g20=a[2]&b[2];
p21=p20&p10;
g21=g20|(p20&g10);
g22=g21|(p21&g00);
if(a[2]== 0 && b[2]==0 && c1==0)
begin
c2=0;
s2=0;
end
else
begin
c2=g22;
s2=p20^g11;
end

//3rd bit
p30=a[3]^b[3];
g30=a[3]&b[3];
p31=p30&p20;
g31=g30|(p30&g20);
g32=g31|(p31&g11);
if(a[3]== 0 && b[3]==0 && c2==0)
begin
c3=0;
s3=0;
end
else
begin
c3=g32;
s3=p30^g22;
end
end
assign sum={s3,s2,s1,s0};
assign final={c3,sum};
assign carry=c3;

endmodule

