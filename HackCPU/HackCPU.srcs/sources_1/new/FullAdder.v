`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2015 09:56:02 PM
// Design Name: 
// Module Name: FullAdder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FullAdder(
    input a, 
    input b,
    input c,
    output sum,
    output carry
    );
    
    wire aPlusB;
    wire carry1;
    wire carry2;
    
    HalfAdder ha1(.a(a), .b(b), .sum(aPlusB), .carry(carry1));
    HalfAdder ha2(.a(aPlusB), .b(c), .sum(sum), .carry(carry2));
    
    or(carry, carry1, carry2);
    
endmodule
