//N=8 composite multiplier
//a=12001300
//b=14001002
//output= 168030225302600
//Level 1
module CompmbcL1(Kl1,a,b,k1,k2,k3,g1,g2,g3,sum,carry1,carry2);
input [31:0]a,b;
output [31:0]k1,k2,k3;
output [63:0]sum;
output [63:0]g1,g2,g3;
output [65:0]Kl1;
output [64:0]carry1,carry2;
wire [15:0]a,b,r,d,e,f;
//output [2:0]count;
reg [63:0]k1,k2,k3;
wire [65:0]Kl1;
reg [63:0]g1,g2,g3;
reg [63:0]sum;
wire [1:0]c;
reg [64:0]carry1,carry2; //carry1==cout for compressor and carry for other adders
integer count;
integer i=0;
assign a=1200;
assign b=1400;
assign r=1300;
assign d=1002;
assign e=2500;
assign f=2402;
booth_mult b1(.x(a),.y(b),.p(k1));
booth_mult b2(.x(r),.y(d),.p(k2));
booth_mult b3(.x(e),.y(f),.p(k3));
assign g1=k1*100000000;
assign g2=(k3-k2-k1)*10000;
assign g3=k2;
assign carry1[0]=0;
assign carry2[0]=0;


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
assign Kl1={c,sum};
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



