// frequency divider which uses triangular progression
// can produce wider range of frequencies for a given number of input bits

module f_divide(clk,enc,rst,out,rate,tick);
	input clk;
	input [2:0] enc;
	input rst;
	output out;
	output [7:0]rate;
	output tick;
	
	wire [7:0]rate_i;
	wire [7:0]cnt;
	wire inner_p;
	wire tick;

	reg [12:0]cntr;
	
	assign rate[7:0]=~rate_i[7:0];

	always @(posedge clk) cntr = cntr + 1;

	counter inner(
	   .clk (clk),
	   .rst (rst),
	   .rate (cnt[7:0]),	// using this results in more frequencies at top range
//	   .rate (rate_i[7:0]),	// using this results in lower final frequency
	   .pulse (inner_p)
	);

	counter outer(
	   .clk (inner_p),
	   .rst (rst),
	   .rate (rate_i[7:0]),
	   .cnt (cnt[7:0]),
	   .pulse (out)
	);

	rotary_enc rotary_enc(
		.clk (cntr[12]),
		.rst (rst),
		.enc (enc[2:0]),
		.va (rate_i[7:0]),
		.tick (tick),
	);

endmodule


module counter(clk,rst,rate,cnt,pulse);
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
endmodule // counter

module rotary_enc(clk, rst,enc, va, tick);
	input clk;
	input rst;
	input [2:0]enc;
	output [7:0]va;
	output tick;
	
	reg [7:0]va;
	reg [2:0]enca;
	reg [2:0]encb;
	reg tick;

	always @(posedge clk, negedge rst) begin
	   if (rst == 0) begin
			va = 8'd8;
			tick = 0;
	   end else begin
			enca <= {enca[1:0],enc[0]};
			encb <= {encb[1:0],enc[1]};
			tick = 0;
			if ((enca==3'b000) & (encb==3'b001)) begin
				va<=va-8'h01;
				tick = 1;
			end
			if ((enca==3'b001) & (encb==3'b000)) begin
				va<=va+8'h01;
				tick = 1;
			end
		end
	end
endmodule  // rotary_enc

