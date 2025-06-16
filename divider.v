module divider(clk,rst,rate,cnt,pulse);
	input clk;
	input rst;
	input [7:0]rate;
	output [7:0]cnt;
	output pulse;

	reg [7:0]cnt;
	reg pulse;

	always@(posedge clk, negedge rst) begin
		if (rst == 8'd0)
			cnt = 8'd0;
		else if (cnt == 8'd0) begin
			cnt = rate;
			pulse = ~pulse;
		end else
			cnt = cnt - 8'd1;
	end
endmodule // divider
