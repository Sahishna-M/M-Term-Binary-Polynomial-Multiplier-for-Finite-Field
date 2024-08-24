//a=12001300
//b=14001002
//output= 168030225302600


module CompmultL1b(Kl1,k1,k2,k3,g1,g2,g3,sum,rst,a,b,c,d,e,f);
output [31:0]k1,k2,k3;
input rst;
input [15:0]a,b,c,d,e,f;
output [65:0]Kl1;
output [63:0]sum;
output[63:0]g1,g2,g3;
reg [31:0]k1,k2,k3;
wire [65:0]Kl1;
reg [63:0]g1,g2,g3;
reg [63:0]sum;
wire [1:0]car;
reg [64:0]carry1,carry2; //carry1==cout for compressor and carry for other adders
integer count;
integer i;
reg [15:0] X, Y;
reg [1:0] temp1,temp2,temp3;
reg E1,E2,E3;
reg [15:0]a1,c1,e1;
always@(i,rst)
begin
	if(rst)
	begin	
		k1 = 32'd0;
		k2 = 32'd0;
		k3 = 32'd0;
		E1 = 1'd0;
		E2 = 1'd0;
		E3 = 1'd0;
		a1 = ~(a)+1;
		c1 = ~(c)+1;
		e1 = ~(e)+1;
		k1[15:0]=b;
		k2[15:0]=d;
		k3[15:0]=f;
		for (i = 0; i < 16; i = i + 1)
		begin
			temp1 = {b[i], E1};
			case (temp1)
				2'd2 : k1 [31 : 16] = k1 [31 : 16] + a1;
				2'd1 : k1 [31 : 16] = k1 [31 : 16] + a;
				default : begin end
			endcase
			k1 = k1 >> 1;
			k1[31] = k1[30];
			E1 = b[i];
			
			temp2 = {d[i], E2};
			case (temp2)
				2'd2 : k2 [31 : 16] = k2 [31 : 16] + c1;
				2'd1 : k2 [31 : 16] = k2 [31 : 16] + c;
				default : begin end
			endcase
			k2 = k2 >> 1;
			k2[31] = k2[30];
			E2 = d[i];

			temp3 = {f[i], E3};
			case (temp3)
				2'd2 : k3 [31 : 16] = k3 [31 : 16] + e1;
				2'd1 : k3 [31 : 16] = k3 [31 : 16] + e;
				default : begin end
			endcase
			k3 = k3 >> 1;
			k3[31] = k3[30];
			E3 = f[i];
			
		end
	
		//assign k1=1200*1400;
		//assign k2=1300*1002;
		//assign k3=2500*2402;
		g1=k1*100000000;
		g2=(k3-k2-k1)*10000;
		g3=k2;
		carry1[0]=0;
		carry2[0]=0;
		i=0;
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
		     		    end

				4: begin
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
end
assign car=carry1[64]+carry2[64];
assign Kl1={car,sum};
endmodule


