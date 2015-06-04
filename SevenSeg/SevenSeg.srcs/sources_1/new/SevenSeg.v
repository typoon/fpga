`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2015 07:40:19 PM
// Design Name: 
// Module Name: SevenSeg
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


module SevenSeg(
    input [3:0] bin,
    output [6:0] seg
    );
    
    // The 7 segment displays in the Nexys 3 has a common anode for each
    // display and 7 cathodes. The same cathodes of each display are 
    // grouped together as a single cathode. They work in a multiplexed way
    //   
    //
    // Gate-level approach
    // +==============================================================
    // |           Input           |     |          Output           |
    // +===========================+=====+===========================+
    // |  A   |  B   |  C   |  D   |     |                           |
    // | b[3] | b[2] | b[1] | b[0] | dec | a | b | c | d | e | f | g |
    // +===========================+=====+===========================+
    // |  0   |  0   |  0   |  0   |  0  | 1 | 1 | 1 | 1 | 1 | 1 | 0 |
    // |  0   |  0   |  0   |  1   |  1  | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 
    // |  0   |  0   |  1   |  0   |  2  | 1 | 1 | 0 | 1 | 1 | 0 | 1 |
    // |  0   |  0   |  1   |  1   |  3  | 1 | 1 | 1 | 1 | 0 | 0 | 1 |
    // |  0   |  1   |  0   |  0   |  4  | 0 | 1 | 1 | 0 | 0 | 1 | 1 |
    // |  0   |  1   |  0   |  1   |  5  | 1 | 0 | 1 | 1 | 0 | 1 | 1 |
    // |  0   |  1   |  1   |  0   |  6  | 1 | 0 | 1 | 1 | 1 | 1 | 1 |
    // |  0   |  1   |  1   |  1   |  7  | 1 | 1 | 1 | 0 | 0 | 0 | 0 |
    // |  1   |  0   |  0   |  0   |  8  | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
    // |  1   |  0   |  0   |  1   |  9  | 1 | 1 | 1 | 1 | 0 | 1 | 1 |
    // |  1   |  0   |  1   |  0   |  A  | 1 | 1 | 1 | 0 | 1 | 1 | 1 |
    // |  1   |  0   |  1   |  1   |  B  | 0 | 0 | 1 | 1 | 1 | 1 | 1 |
    // |  1   |  1   |  0   |  0   |  C  | 1 | 0 | 0 | 1 | 1 | 1 | 0 |
    // |  1   |  1   |  0   |  1   |  D  | 0 | 1 | 1 | 1 | 1 | 0 | 1 |
    // |  1   |  1   |  1   |  0   |  E  | 1 | 0 | 0 | 1 | 1 | 1 | 1 |
    // |  1   |  1   |  1   |  1   |  F  | 1 | 0 | 0 | 0 | 1 | 1 | 1 |
    // +===========================+=====+===========================+
    //
    // Without Karnaugh's Map:
    //
    // a = A'B'C'D' + A'B'CD' + A'B'CD + A'BC'D' + A'BCD' + A'BCD + AB'C'D' +
    //     AB'C'D + AB'CD' + ABC'D' + ABCD' + ABCD
    //
    // With Karnaugh's Map:
    // a = A'B'D' + A'C + A'BD + ABC + ACD' + AC'D' + AB'C'
    // b = A'B' + A'C'D' + A'CD + AC'D + AB'C' + AB'D'
    // c = A'C' + A'D + A'B + C'D + AB' 
    // d = A'B'D' + A'B'C + BC'D + BCD' + AC' + AB'D
    // e = B'C'D' + CD' + AB + AC
    // f = C'D' + A'BC' + AB' + BCD' + AC
    // g = A'B'C + CD' + A'BC' + AD + AB' + AC
    //

    wire a, b, c, d;
    wire notA, notB, notC, notD;

    wire aw1, aw2, aw3, aw4, aw5, aw6, aw7, awr;
    wire bw1, bw2, bw3, bw4, bw5, bw6, bwr;
    wire cw1, cw2, cw3, cw4, cw5, cwr; 
    wire dw1, dw2, dw3, dw4, dw5, dw6, dwr;
    wire ew1, ew2, ew3, ew4, ewr;
    wire fw1, fw2, fw3, fw4, fw5, fwr;
    wire gw1, gw2, gw3, gw4, gw5, gw6, gwr;

    assign a = bin[3];
    assign b = bin[2];
    assign c = bin[1];
    assign d = bin[0];

    not _n1(notA, a);
    not _n2(notB, b);
    not _n3(notC, c);
    not _n4(notD, d);
    
    // Segment A
    // a = A'B'D' + A'C + A'BD + ABC + ACD' + AC'D' + AB'C'
    and _and_a1(aw1, notA, notB, notD);
    and _and_a2(aw2, notA, c);
    and _and_a3(aw3, notA, b, d);
    and _and_a4(aw4, a, b, c);
    and _and_a5(aw5, a, c, notD);
    and _and_a6(aw6, a, notC, notD);
    and _and_a7(aw7, a, notB, notC);
    or _or_a(awr, aw1, aw2, aw3, aw4, aw5, aw6, aw7);
    // Invert the output because this signal goes to a cathode
    // meaning we turn on our segment if this signal is 0.
    not(seg[0], awr); 

    // Segment B
    // b = A'B' + A'C'D' + A'CD + AC'D + AB'C' + AB'D'
    and _and_b1(bw1, notA, notB);
    and _and_b2(bw2, notA, notC, notD);
    and _and_b3(bw3, notA, c, d);
    and _and_b4(bw4, a, notC, d);
    and _and_b5(bw5, a, notB, notC);
    and _and_b6(bw6, a, notB, notD);
    or _or_b(bwr, bw1, bw2, bw3, bw4, bw5, bw6);
    not(seg[1], bwr);
    
    // Segment C
    // c = A'C' + A'D + A'B + C'D + AB'
    and _and_c1(cw1, notA, notC);
    and _and_c2(cw2, notA, d);
    and _and_c3(cw3, notA, b);
    and _and_c4(cw4, notC, d);
    and _and_c5(cw5, a, notB);
    or _or_c(cwr, cw1, cw2, cw3, cw4, cw5);
    not(seg[2], cwr);
    
    // Segment D 
    // d = A'B'D' + A'B'C + BC'D + BCD' + AC' + AB'D
    and _and_d1(dw1, notA, notB, notD);
    and _and_d2(dw2, notA, notB, c);
    and _and_d3(dw3, b, notC, d);
    and _and_d4(dw4, b, c, notD);
    and _and_d5(dw5, a, notC);
    and _and_d6(dw6, a, notB, d);
    or _or_d(dwr, dw1, dw2, dw3, dw4, dw5, dw6);
    not(seg[3], dwr);

    // Segment E    
    // e = B'C'D' + CD' + AB + AC
    and _and_e1(ew1, notB, notC, notD);
    and _and_e2(ew2, c, notD);
    and _and_e3(ew3, a, b);
    and _and_e4(ew4, a, c);
    or _or_e(ewr, ew1, ew2, ew3, ew4);
    not(seg[4], ewr);
    
    // Segment F
    // f = C'D' + A'BC' + AB' + BCD' + AC
    and _and_f1(fw1, notC, notD);
    and _and_f2(fw2, notA, b, notC);
    and _and_f3(fw3, a, notB);
    and _and_f4(fw4, b, c, notD);
    and _and_f5(fw5, a, c);
    or _or_f(fwr, fw1, fw2, fw3, fw4, fw5);
    not(seg[5], fwr);

    // Segment G    
    // g = A'B'C + CD' + A'BC' + AD + AB' + AC
    and _and_g1(gw1, notA, notB, c);
    and _and_g2(gw2, c, notD);
    and _and_g3(gw3, notA, b, notC);
    and _and_g4(gw4, a, d);
    and _and_g5(gw5, a, notB);
    and _and_g6(gw6, a, c);
    or _or_g(gwr, gw1, gw2, gw3, gw4, gw5, gw6);
    not(seg[6], gwr);
   
endmodule
