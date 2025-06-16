module rotary_enc(clk, rst, enc, value, tick);
	input clk;
	input rst;
	input [2:0]enc;
	output [7:0]value;
	output tick;
	
	reg [7:0]value;
	reg [2:0]enca;
	reg [2:0]encb;
	reg tick;

	initial value<=16'h0;
	initial tick <=0;

	always @(posedge clk, negedge rst) begin
	   if (rst == 0) begin
			value = 8'd8;
			tick = 0;
	   end else begin
			enca <= {enca[1:0],enc[0]};
			encb <= {encb[1:0],enc[1]};
			tick = 0;
			if ((enca==3'b000) & (encb==3'b001)) begin
				value<=value-8'h01;
				tick = 1;
			end
			if ((enca==3'b001) & (encb==3'b000)) begin
				value<=value+8'h01;
				tick = 1;
			end
		end
	end

endmodule  // rotary_enc
