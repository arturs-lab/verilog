// http://www.deathbylogic.com/2013/12/binary-to-binary-coded-decimal-bcd-converter/
module bcd(binary, hundreds, tens, ones);
   // I/O Signal Definitions
   input  [7:0] binary;
   output reg [1:0] hundreds;
   output reg [3:0] tens;
   output reg [3:0] ones;
  
   // Internal variable for storing bits
   reg [17:0] shift;
   integer i;
  
   always @(binary)
   begin
      // Clear previous binary and store new binary in shift register
      shift[17:8] = 9'd0;
      shift[7:0] = binary;
      
      // Loop eight times
      for (i=0; i<8; i=i+1) begin
         if (shift[11:8] >= 4'd5)
            shift[11:8] = shift[11:8] + 4'd3;
            
         if (shift[15:12] >= 4'd5)
            shift[15:12] = shift[15:12] + 4'd3;
            
// this will never happen since max hundreds is "2"
//         if (shift[19:16] >= 5)
//            shift[19:16] = shift[19:16] + 3;
        
         // Shift entire register left once
         shift = shift << 1;
      end
      
      // Push decimal numbers to output
      hundreds = shift[17:16];
      tens     = shift[15:12];
      ones     = shift[11:8];
   end
 
endmodule
