`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2015 09:54:42 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [15:0] x,
    input [15:0] y,
    input zx, nx,
    input zy, ny,
    input f,
    input no,
    output [15:0] out,
    output zr,
    output ng
    );
    
    wire a, b, c;
    wire sum, carry;
    
    FullAdder fa(.a(a), .b(b), .c(c), .sum(sum), .carry(carry));
    Add16 a16(.a(x), .b(y), .out(out));
    
endmodule
