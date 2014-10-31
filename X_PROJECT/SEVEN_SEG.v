`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:05:00 10/30/2014 
// Design Name: 
// Module Name:    SEVEN_SEG 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SEVEN_SEG(
   clock,
	reset,
	in0, 
	in1,
	in2,
	in3,  
	a, 
	b, 
	c, 
	d, 
	e, 
	f,
	g, 
	an
);
 
//Input port
input wire clock;
input wire reset;
input wire [4:0] in0;
input wire [4:0] in1;
input wire [4:0] in2;
input wire [4:0] in3;
 
//Output Ports
output wire a;
output wire b;
output wire c;
output wire d;
output wire e;
output wire f;
output wire g;
output wire [3:0] an;


//Others
reg [4:0] sseg; //the 7 bit register to hold the data to output
reg [3:0] an_temp; //register for the 4 bit enable

 
//----------------------CODE -----------------------------------------------
 
 
localparam N = 18;
 
reg [N-1:0]count; //the 18 bit counter which allows us to multiplex at 1000Hz
 
always @ (posedge clock or posedge reset)
 begin
  if (reset)
   count <= 1'b0;
  else
   count <= count + 1'b1;
 end
 
 
always @ (*)

 begin
  case(count[N-1:N-2]) //using only the 2 MSB's of the counter
    
   2'b00 :  //When the 2 MSB's are 00 enable the fourth display
    begin
     sseg = in0;
     an_temp = 4'b1110;
    end
    
   2'b01:  //When the 2 MSB's are 01 enable the third display
    begin
     sseg = in1;
     an_temp = 4'b1101;
    end
    
   2'b10:  //When the 2 MSB's are 10 enable the second display
    begin
     sseg = in2;
     an_temp = 4'b1011;
    end
     
   2'b11:  //When the 2 MSB's are 11 enable the first display
    begin
     sseg = in3;
     an_temp = 4'b1111;
    end
  endcase
 end
 
assign an = an_temp;
 
 
reg [6:0] sseg_temp; // 7 bit register to hold the binary value of each input given
 

// 7-segment encoding
//      0
//     ---
//  5 |   | 1
//     --- <--6
//  4 |   | 2
//     ---
//      3

always @ (*)

		 begin
		  case(sseg)
		  
				5'd0 : sseg_temp = 7'b1000000; //to display 0
				5'd1 : sseg_temp = 7'b1111001; //to display 1
				5'd2 : sseg_temp = 7'b0100100; //to display 2
				5'd3 : sseg_temp = 7'b0110000; //to display 3
				5'd4 : sseg_temp = 7'b0011001; //to display 4
				5'd5 : sseg_temp = 7'b0010010; //to display 5
				5'd6 : sseg_temp = 7'b0000010; //to display 6
				5'd7 : sseg_temp = 7'b1111000; //to display 7
				5'd8 : sseg_temp = 7'b0000000; //to display 8
				5'd9 : sseg_temp = 7'b0010000; //to display 9
				5'd10 : sseg_temp = 7'b0001000; //to display A
				5'd11 : sseg_temp = 7'b0000011; //to display B
				5'd12 : sseg_temp = 7'b1000110; //to display C
				5'd13 : sseg_temp = 7'b0100001; //to display D
				5'd14 : sseg_temp = 7'b0000110; //to display E
				5'd15 : sseg_temp = 7'b0001110; //to display F
				
				default : sseg_temp = 7'b1111111; //dash
				
		  endcase
 end
 
assign {g, f, e, d, c, b, a} = sseg_temp; 

 
endmodule



