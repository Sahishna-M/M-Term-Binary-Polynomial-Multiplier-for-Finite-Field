// COMPOSITE WITH KOGGE STONE

//a=12001300
//b=14001002
//output= 168030225302600
module compkbL1(Comp_Kogge_BoothL1,booth1,booth2,booth3,g1,g2,g3);
output [63:0]Comp_Kogge_BoothL1;
output [31:0]booth1,booth2,booth3;
output [63:0]g1,g2,g3;
wire [63:0]g1,g2,g3;
wire [63:0]sum1,sum2;
wire [15:0]a,b,c,d,e,f;
wire carry1,carry2;
assign a=1200;
assign b=1400;
assign c=1300;
assign d=1002;
assign e=2500;
assign f=2402;
booth_mult b1(.x(a),.y(b),.p(booth1));
booth_mult b2(.x(c),.y(d),.p(booth2));
booth_mult b3(.x(e),.y(f),.p(booth3));
assign g1=booth1*100000000;
assign g2=(booth3-booth2-booth1)*10000;
assign g3=booth2;
kogge64bit r1(.sum(sum1),.carry(carry1),.cin(1'd0),.a(g1),.b(g2));
kogge64bit r2(.sum(sum2),.carry(carry2),.cin(carry1),.a(sum1),.b(g3));
assign Comp_Kogge_BoothL1= {carry2,sum2};
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
wire g0a,g0b,g0c,p00,g00,c0,s0,p10,g10,g11,c1,s1,p20,g20,p21,g21,g22,c2,s2,p30,g30,p31,g31,g32,c3,s3;
assign g0a=a[0]&cin;
assign g0b=b[0]&cin;
assign g0c=a[0]&b[0];

assign p00=a[0]^b[0];
assign g00=g0a|g0b|g0c;
assign c0=g00;
assign s0=p00^cin;

assign p10=a[1]^b[1];
assign g10=a[1]&b[1];
assign g11=g10|(p10&g00);
assign c1=g11;
assign s1=p10^g00;

assign p20=a[2]^b[2];
assign g20=a[2]&b[2];
assign p21=p20&p10;
assign g21=g20|(p20&g10);
assign g22=g21|(p21&g00);
assign c2=g22;
assign s2=p20^g11;

assign p30=a[3]^b[3];
assign g30=a[3]&b[3];
assign p31=p30&p20;
assign g31=g30|(p30&g20);
assign g32=g31|(p31&g11);
assign c3=g32;
assign s3=p30^g22;

assign sum={s3,s2,s1,s0};
assign final={c3,sum};
assign carry=c3;
endmodule





module booth_mult (p, x, y);
parameter width=16;
parameter N =8;
input[width-1:0]x, y;
output[width+width-1:0]p;
reg [2:0] cc[N-1:0];
reg [width:0] pp[N-1:0];
reg [width+width-1:0] spp[N-1:0];
reg [width+width-1:0] prod;
wire [width:0] inv_x;
integer k,i;
assign inv_x = {~x[width-1],~x}+1;
always @ (x or y or inv_x)
begin
 	cc[0] = {y[1],y[0],1'b0};
 	for(k=1;k<N;k=k+1)
 		cc[k] = {y[2*k+1],y[2*k],y[2*k-1]};
 		for(k=0;k<N;k=k+1)
 		begin
 			case(cc[k])
 			3'b001 , 3'b010 : pp[k] = {x[width-1],x};
 			3'b011 : pp[k] = {x,1'b0};
 			3'b100 : pp[k] = {inv_x[width-1:0],1'b0};
 			3'b101 , 3'b110 : pp[k] = inv_x;
 			default : pp[k] = 0;
 		endcase
 		spp[k] = $signed(pp[k]);
 		for(i=0;i<k;i=i+1)
 			spp[k] = {spp[k],2'b00}; //multiply by 2 to the power x or shifting operation
 		end //for(kk=0;kk<N;kk=kk+1)
	prod = spp[0];
 	for(k=1;k<N;k=k+1)
 	prod = prod + spp[k];
end
assign p = prod;
endmodule
			







