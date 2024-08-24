//N=8 composite multiplier
//a=12001300
//b=14001002
//output= 168030225302600
//Level 1
module CompmultaddL1(Comp_Multiple_Adders_L1,a,b,pp1,pp2,pp3,g1,g2,g3,sum,carry1,carry2,count);
input [31:0]a,b;
output [63:0]pp1,pp2,pp3,sum;
output [63:0]g1,g2,g3;
output [65:0]Comp_Multiple_Adders_L1;
output [64:0]carry1,carry2;
output count;
//output [2:0]count;
reg [63:0]pp1,pp2,pp3;
wire [65:0]Kl1;
reg [63:0]g1,g2,g3;
reg [63:0]sum;
wire [1:0]c;
reg [64:0]carry1,carry2; //carry1==cout for compressor and carry for other adders
integer count;
integer i=0;
initial
begin
pp1=1200*1400;
pp2=1300*1002;
pp3=2500*2402;
g1=pp1*100000000;
g2=(pp3-pp2-pp1)*10000;
g3=pp2;
carry1[0]=0;
carry2[0]=0;
end

always@(i)
begin
for(i=0;i<64;i=i+1)
begin
count=0;
if(g1[i] == 1)
count = count+1;
else
count = count;
if(g2[i] == 1)
count = count+1;
else
count = count;
if(g3[i] == 1)
count = count+1;
else
count = count;
if(carry1[i] == 1)
count = count+1;
else
count = count;
if (carry2[i] == 1)
count = count+1;
else
count = count;

case(count)
0: begin
sum[i]=0;
carry1[i+1]=0;
carry2[i+1]=0;
     end

1: begin
sum[i]=1;
carry1[i+1]=0;
carry2[i+1]=0;
     end

2: begin
      sum[i]=0;
carry1[i+1]=1;
carry2[i+1]=0;
     end

3: begin
sum[i]=1;
carry1[i+1]=1;
carry2[i+1]=0;
/*if(g1[i]==1 && g2[i]==1 && k2[i]==1)
begin
sum[i] = g1[i]^g2[i]^k2[i];
carry1[i+1] = g1[i]&g2[i]|g2[i]&k2[i]|k2[i]&g1[i];
end

if(g2[i]==1 && k2[i]==1 && carry1[i]==1)
begin
sum[i] = g2[i]^k2[i]^carry1[i];
carry1[i+1] = g2[i]&k2[i]|k2[i]&carry1[i]|carry1[i]&g2[i];
end

if(k2[i]==1 && carry1[i]==1 && g1[i]==1)
begin
sum[i] = k2[i]^carry1[i]^g1[i];
carry1[i+1] = k2[i]&carry1[i]|carry1[i]&g1[i]|g1[i]&k2[i];
end

if(carry1[i]==1 && g1[i]==1 && g2[i]==1)
begin
sum[i] = carry1[i]^g1[i]^g2[i];
carry1[i+1] = carry1[i]&g1[i]|g1[i]&g2[i]|g2[i]&carry1[i];
end */
    end

4: begin

/*sum[i]=g1[i]^g2[i]^g3[i]^m4^carry1[i];
carry1[i+1]=((g1[i]^g2[i])*g3[i]) + (~(g1[i]^g2[i])*g1[i]);
carry[i]=((g1[i]^g2[i]^g3[i]^m4)*carry1[i])+(~(g1[i]^g2[i]^g3[i]^m4)*m4);*/
sum[i]=0;
carry1[i+1]=1;
carry2[i+1]=1;
 
    end
5: begin
sum[i]=1;
carry1[i+1]=1;
carry2[i+1]=1;
 
    end


     default: begin
sum[i]=0;
carry1[i+1]=0;
end

endcase                                                                                                                  
end
end
assign c=carry1[64]+carry2[64];
assign Comp_Multiple_Adders_L1={c,sum};
endmodule




//Level 2
module CompmultaddL2(Comp_Multiple_Adders_L2,k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33);
output [63:0]k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33;
output [65:0]Comp_Multiple_Adders_L2;
reg [63:0]g3,g4,g5;
reg [63:0]sum2;
wire [65:0]Kl2;
//output [64:0]carry3,carry4;
reg [64:0]carry3,carry4;
//output [2:0]count2;
reg [63:0]k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33;
wire [1:0]c2;
integer count2;
integer i=0;

initial
begin
k11=12*14;
k12=0*0;
k13=12*14;
k1=(10000*k11)+(100*(k13-k12-k11))+k12;
k21=13*10;
k22=0*2;
k23=13*12;
k2=(10000*k21)+(100*(k23-k22-k21))+k22;
k31=25*24;
k32=0*2;
k33=25*26;
k3=(10000*k31)+(100*(k33-k32-k31))+k32;
g3=100000000*k1;
g4=10000*(k3-k2-k1);
g5=k2;
carry3[0]=0;
carry4[0]=0;
end

always@(i)
begin
for(i=0;i<64;i=i+1)
begin
		count2=0;
		if(g3[i] == 1)
			count2 = count2+1;
		else
			count2 = count2;
		if(g4[i] == 1)
			count2 = count2+1;
		else
			count2 = count2;
		if(g5[i] == 1)
			count2 = count2+1;
		else
			count2 = count2;
		if(carry3[i] == 1)
			count2 = count2+1;
		else
			count2 = count2;
		if (carry4[i] == 1)
			count2 = count2+1;
		else
			count2 = count2;

	case(count2)
		0: begin
			sum2[i]=0;
			carry3[i+1]=0;
			carry4[i+1]=0;
		      end

		1: begin
			sum2[i]=1;
			carry3[i+1]=0;
			carry4[i+1]=0;
		      end

		2: begin
		      	sum2[i]=0;
			carry3[i+1]=1;
			carry4[i+1]=0;
		      end

		3: begin
			sum2[i]=1;
			carry3[i+1]=1;
			carry4[i+1]=0;
		    end
		4: begin
			
				sum2[i]=0;
				carry3[i+1]=1;
				carry4[i+1]=1;
		  		
		     end
		5: begin
				sum2[i]=1;
				carry3[i+1]=1;
				carry4[i+1]=1;
		  		
		     end

				
	      default: begin
				sum2[i]=0;
				carry3[i+1]=0;
			end	
			
	endcase                                                                                                                   
end
end
assign c2=carry3[64]+carry4[64];
assign Comp_Multiple_Adders_L2={c2,sum2};
endmodule

//Level 3

module CompmultaddL3(Comp_Multiple_Adders_L3,k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33,k111,k112,k113,k121,k122,k123,k131,k132,k133,k211,k212,k213,k221,k222,k223,k231,k232,k233,k311,k312,k313,k321,k322,k323,k331,k332,k333);
output [63:0]k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33,k111,k112,k113,k121,k122,k123,k131,k132,k133,k211,k212,k213,k221,k222,k223,k231,k232,k233,k311,k312,k313,k321,k322,k323,k331,k332,k333;
output [65:0]Comp_Multiple_Adders_L3;
wire [65:0]Kl3;
reg [63:0]g6,g7,g8;
reg [63:0]sum3;
reg [64:0]carry5,carry6;
reg [63:0]k1,k2,k3,k11,k12,k13,k21,k22,k23,k31,k32,k33,k111,k112,k113,k121,k122,k123,k131,k132,k133,k211,k212,k213,k221,k222,k223,k231,k232,k233,k311,k312,k313,k321,k322,k323,k331,k332,k333;
wire [1:0]c3;
integer count3;
integer i=0;

initial
begin
k111=1*1;
k112=4*2;
k113=3*5;
k11=(100*k111)+(10*(k113-k112-k111))+k112;
k121=0;
k122=0;
k123=0;
k12=(100*k121)+(10*(k123-k122-k121))+k122;
k131=1*1;
k132=2*4;
k133=3*5;
k13=(k131*100)+((k133-k132-k131)*10)+k132;
k1=(10000*k11)+(100*(k13-k12-k11))+k12;
k211=1*1;
k212=3*0;
k213=4*1;
k21=(k211*100)+((k213-k212-k211)*10)+k212;
k221=0*0;
k222=0*2;
k223=0*2;
k22=(k221*100)+((k223-k222-k221)*10)+k222;
k231=1*1;
k232=3*2;
k233=4*3;
k23=(k231*100)+((k233-k232-k231)*10)+k232;
k2=(k21*10000)+((k23-k22-k21)*100)+k22;
k311=2*2;
k312=5*4;
k313=7*6;
k31=(k311*100)+((k313-k312-k311)*10)+k312;
k321=0*0;
k322=0*2;
k323=0*2;
k32=(k321*100)+((k323-k322-k321)*10)+k322;
k331=2*2;
k332=5*6;
k333=7*8;
k33=(k331*100)+((k333-k332-k331)*10)+k332;
k3=(k31*10000)+((k33-k32-k31)*100)+k32;
g6=k1*100000000;
g7=(k3-k2-k1)*10000;
g8=k2;
end

always@(i)
begin
for(i=0;i<64;i=i+1)
begin
		count3=0;
		if(g6[i] == 1)
			count3 = count3+1;
		else
			count3 = count3;
		if(g7[i] == 1)
			count3 = count3+1;
		else
			count3 = count3;
		if(g8[i] == 1)
			count3 = count3+1;
		else
			count3 = count3;
		if(carry5[i] == 1)
			count3 = count3+1;
		else
			count3 = count3;
		if (carry6[i] == 1)
			count3 = count3+1;
		else
			count3 = count3;

	case(count3)
		0: begin
			sum3[i]=0;
			carry5[i+1]=0;
			carry6[i+1]=0;
		      end

		1: begin
			sum3[i]=1;
			carry5[i+1]=0;
			carry6[i+1]=0;
		      end

		2: begin
		      	sum3[i]=0;
			carry5[i+1]=1;
			carry6[i+1]=0;
		      end

		3: begin
			sum3[i]=1;
			carry5[i+1]=1;
			carry6[i+1]=0;
		    end
		4: begin
			
				sum3[i]=0;
				carry5[i+1]=1;
				carry6[i+1]=1;
		  		
		     end
		5: begin
				sum3[i]=1;
				carry5[i+1]=1;
				carry6[i+1]=1;
		  		
		     end

				
	      default: begin
				sum3[i]=0;
				carry5[i+1]=0;
			end	
			
	endcase                                                                                                                   
end
end
assign c3=carry5[64]+carry6[64];
assign Comp_Multiple_Adders_L3={c3,sum3};
endmodule
