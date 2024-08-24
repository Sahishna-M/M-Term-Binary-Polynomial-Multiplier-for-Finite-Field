//N=8 composite multiplier
//a=12001300
//b=14001002
//product= 168030225302600
module CompmultaddRCAL1(Kl1,k1,k2,k3,count,g1,g2,g3,sum,carry1);
output [63:0]k1,k2,k3,sum;
output [63:0]g1,g2,g3;
output [64:0]Kl1;
output [64:0]carry1;
output [2:0]count;
reg [63:0]k1,k2,k3;
wire [64:0]Kl1;
reg a,ac,b,bc,c,cc;
reg [63:0]g1,g2,g3;
reg [63:0]sum;
reg [63:0]carry;
reg [63:0]sumcomp,carrycomp;
//reg [63:0]carry1comp
reg [64:0]carry1; //carry1==cout for compressor and carry for other adders
integer count;
integer m4,i=0;
initial
begin
k1=1200*1400;
k2=1300*1002;
k3=2500*2402;
g1=k1*100000000;
g2=(k3-k2-k1)*10000;
g3=k2;
m4=0;
carry1[0]=0;
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

	case(count)
		0: begin
			sum[i]=0;
			carry1[i+1]=0;
		      end

		1: begin
			sum[i]=1;
			carry1[i+1]=0;
		      end

		2: begin
		      	sum[i]=0;
			carry1[i+1]=1;
		      end

		3: begin
			sum[i]=1;
			carry1[i+1]=1;
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
			a=0;
			b=0;
			ac=0;
			bc=0;
			a=g1[i]^g2[i]^g3[i];
			ac=g1[i]&g2[i]|g2[i]&g3[i]|g3[i]&g1[i];
			b=a^carry1[i];
			bc=a&carry1[i];
			sum[i]=a^b;
			carry[i]=a&b;
			
			
		     end
	      default: begin
				sum[i]=0;
				carry1[i+1]=0;
			end	
			
	endcase                                                                                                                   
end
end
assign Kl1={carry1[64],sum};
endmodule





