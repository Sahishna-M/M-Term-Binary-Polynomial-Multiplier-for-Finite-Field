module boothmul(X, Y, Z,rst);
input [15:0] X, Y;
input rst;
output [31:0] Z;
reg [31:0] Z;
reg [1:0] temp;
integer i;
reg E1;
reg [15:0] Y1;
reg [16:0]X1;
always @ (X, Y,rst)
begin
	if(rst)
	begin
		Z = 32'd0;
		E1 = 1'd0;
		X1 = ~(X)+1;
		Z[15:0]=Y;
		for (i = 0; i < 16; i = i + 1)
		begin
			temp = {Y[i], E1};
			case (temp)
				2'd2 : Z [31 : 16] = Z [31 : 16] + X1;
				2'd1 : Z [31 : 16] = Z [31 : 16] + X;
				default : begin end
			endcase
			Z = Z >> 1;
			Z[31] = Z[30];
			E1 = Y[i];
		end
	end
end
endmodule