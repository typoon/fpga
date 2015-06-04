#1. Introduction

This is a simple driver for a Seven Segment display. This has been built with
the Nexys3 board in mind, using a Xilinx Spartan6 XC6SLX16CSG324 FPGA.

For this board, there are 4 Seven Segment displays each with a common anode and
shared cathodes among each segment (meaning that segment A on display 1 is the
same as segment A in displays 2, 3 and 4).

In this project, all displays are being used to display the same information as
a multiplexer would be needed to drive each one individually and this is not the
objective of this project.

The implementation uses Gate Level modeling in order to display the complexity
of using such technique and as a refreshment on how to use Karnaugh Maps.

#2. 7-Segment Display

A regular 7-Segment display looks somewhat like the following:

          a
     /=========\
    ||         ||
    ||f       b||
    ||    g    ||
     <=========>
    ||         ||
    ||e       c||
    ||    d    ||
     \=========/


Our module will take as an input the binary representation of a 4 bit number (0
to F) and will have as an output a 7 bit bus, where bit 0 represents segment a,
bit 1 represents segment b, and so on.

Here is the module signature:

```verilog
module SevenSeg(
    input [3:0] bin,
    output [6:0] seg
    );
```

The following truth table represents what segments should be turned on in order
to represent the desired number.

    +==============================================================
    |           Input           |     |          Output           |
    +===========================+=====+===========================+
    |  A   |  B   |  C   |  D   |     |                           |
    | b[3] | b[2] | b[1] | b[0] | dec | a | b | c | d | e | f | g |
    +===========================+=====+===========================+
    |  0   |  0   |  0   |  0   |  0  | 1 | 1 | 1 | 1 | 1 | 1 | 0 |
    |  0   |  0   |  0   |  1   |  1  | 0 | 1 | 1 | 0 | 0 | 0 | 0 | 
    |  0   |  0   |  1   |  0   |  2  | 1 | 1 | 0 | 1 | 1 | 0 | 1 |
    |  0   |  0   |  1   |  1   |  3  | 1 | 1 | 1 | 1 | 0 | 0 | 1 |
    |  0   |  1   |  0   |  0   |  4  | 0 | 1 | 1 | 0 | 0 | 1 | 1 |
    |  0   |  1   |  0   |  1   |  5  | 1 | 0 | 1 | 1 | 0 | 1 | 1 |
    |  0   |  1   |  1   |  0   |  6  | 1 | 0 | 1 | 1 | 1 | 1 | 1 |
    |  0   |  1   |  1   |  1   |  7  | 1 | 1 | 1 | 0 | 0 | 0 | 0 |
    |  1   |  0   |  0   |  0   |  8  | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
    |  1   |  0   |  0   |  1   |  9  | 1 | 1 | 1 | 1 | 0 | 1 | 1 |
    |  1   |  0   |  1   |  0   |  A  | 1 | 1 | 1 | 0 | 1 | 1 | 1 |
    |  1   |  0   |  1   |  1   |  B  | 0 | 0 | 1 | 1 | 1 | 1 | 1 |
    |  1   |  1   |  0   |  0   |  C  | 1 | 0 | 0 | 1 | 1 | 1 | 0 |
    |  1   |  1   |  0   |  1   |  D  | 0 | 1 | 1 | 1 | 1 | 0 | 1 |
    |  1   |  1   |  1   |  0   |  E  | 1 | 0 | 0 | 1 | 1 | 1 | 1 |
    |  1   |  1   |  1   |  1   |  F  | 1 | 0 | 0 | 0 | 1 | 1 | 1 |
    +===========================+=====+===========================+
 
And below are the boolean expressions for each segment:


    a = A'B'D' + A'C + A'BD + ABC + ACD' + AC'D' + AB'C'
    b = A'B' + A'C'D' + A'CD + AC'D + AB'C' + AB'D'
    c = A'C' + A'D + A'B + C'D + AB' 
    d = A'B'D' + A'B'C + BC'D + BCD' + AC' + AB'D
    e = B'C'D' + CD' + AB + AC
    f = C'D' + A'BC' + AB' + BCD' + AC
    g = A'B'C + CD' + A'BC' + AD + AB' + AC

All these have been derived using Karnaugh Maps. For information on Karnaugh
Maps, check the following wikipedia link: [Karnaugh Map](http://en.wikipedia.org/wiki/Karnaugh_map)

This display has a common anode, and each segment is then driven by the cathode.
This means that in order to get a segment to light, we need to set its value to
logic level 0. I just found this out after I had all boolean expressions
already written, so I opted on inverting the result of the expression at the end
when assigning its value to the output bus.
