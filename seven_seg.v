module seven_seg(clk,d,dp,CC,AN,D);
	input clk;
	input [7:0] d;
	input [1:0] dp;
	output [1:0] CC;
	output [6:0] AN;
	output D;
	
	wire [3:0] n;
	wire D;
	wire [6:0] AN;
	
	assign CC[0] = clk;
	assign CC[1] = ~clk;
	
	assign n = (clk) ? d[7:4] : d[3:0];
	assign D = (clk) ? dp[1] : dp[0];

	assign AN = 
	(n==4'b0000) ? 7'b0111111 : 
	(n==4'b0001) ? 7'b0000110 : 
	(n==4'b0010) ? 7'b1011011 : 
	(n==4'b0011) ? 7'b1001111 : 
	(n==4'b0100) ? 7'b1100110 : 
	(n==4'b0101) ? 7'b1101101 : 
	(n==4'b0110) ? 7'b1111101 : 
	(n==4'b0111) ? 7'b0000111 : 
	(n==4'b1000) ? 7'b1111111 : 
	(n==4'b1001) ? 7'b1101111 : 
	(n==4'b1010) ? 7'b1110111 : 
	(n==4'b1011) ? 7'b1111100 : 
	(n==4'b1100) ? 7'b1011000 : 
	(n==4'b1101) ? 7'b1011110 : 
	(n==4'b1110) ? 7'b1111001 : 7'b1110001;

endmodule // seven_seg
