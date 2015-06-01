`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2015 09:56:02 PM
// Design Name: 
// Module Name: Inc16
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


module Inc16(
    input [15:0] in,
    output [15:0] out
    );
    
    Add16 add(.out(out), .a(in), .b(16'b1));
    
endmodule
