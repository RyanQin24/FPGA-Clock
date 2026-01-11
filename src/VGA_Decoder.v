`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2026 09:35:04 AM
// Design Name: 
// Module Name: VGA_Decoder
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


module VGA_Decoder(
    input wire [9:0] vert_Cnt,
    input wire [9:0] horiz_Cnt,
    input wire [6:0] digit1,
    input wire [6:0] digit2, 
    input wire [6:0] digit3, 
    input wire [6:0] digit4, 
    input wire [6:0] digit5,
    input wire [6:0] digit6,
    output drive_enable
    );
    wire Digit1SegA;
    wire Digit1SegB;
    wire Digit1SegF;
    wire Digit1SegG;
    wire Digit1SegC;
    wire Digit1SegE;
    wire Digit1SegD;
    wire Digit1;
    
    wire Digit2SegA;
    wire Digit2SegB;
    wire Digit2SegF;
    wire Digit2SegG;
    wire Digit2SegC;
    wire Digit2SegE;
    wire Digit2SegD;
    wire Digit2;
    
    wire Digit3SegA;
    wire Digit3SegB;
    wire Digit3SegF;
    wire Digit3SegG;
    wire Digit3SegC;
    wire Digit3SegE;
    wire Digit3SegD;
    wire Digit3;
    
    wire Digit4SegA;
    wire Digit4SegB;
    wire Digit4SegF;
    wire Digit4SegG;
    wire Digit4SegC;
    wire Digit4SegE;
    wire Digit4SegD;
    wire Digit4;
    
    wire Digit5SegA;
    wire Digit5SegB;
    wire Digit5SegF;
    wire Digit5SegG;
    wire Digit5SegC;
    wire Digit5SegE;
    wire Digit5SegD;
    wire Digit5;
    
    wire Digit6SegA;
    wire Digit6SegB;
    wire Digit6SegF;
    wire Digit6SegG;
    wire Digit6SegC;
    wire Digit6SegE;
    wire Digit6SegD;
    wire Digit6;
    
    wire colon1;
    wire colon2;
  
    parameter Hbias = 10'd144;
    
    assign Digit1 = Digit1SegA || Digit1SegB || Digit1SegF || Digit1SegG|| Digit1SegC || Digit1SegE || Digit1SegD;
    assign Digit2 = Digit2SegA || Digit2SegB || Digit2SegF || Digit2SegG|| Digit2SegC || Digit2SegE || Digit2SegD;
    assign Digit3 = Digit3SegA || Digit3SegB || Digit3SegF || Digit3SegG|| Digit3SegC || Digit3SegE || Digit3SegD;
    assign Digit4 = Digit4SegA || Digit4SegB || Digit4SegF || Digit4SegG|| Digit4SegC || Digit4SegE || Digit4SegD;
    assign Digit5 = Digit5SegA || Digit5SegB || Digit5SegF || Digit5SegG|| Digit5SegC || Digit5SegE || Digit5SegD;
    assign Digit6 = Digit6SegA || Digit6SegB || Digit6SegF || Digit6SegG|| Digit6SegC || Digit6SegE || Digit6SegD;
    
    assign drive_enable = Digit1 || Digit2 || colon1 || Digit3 || Digit4 || colon2 || Digit5 || Digit6;
   
    //vertical segment sizing constraint (changable) 
    parameter segHsize = 10'd65;
    parameter segVsize = 10'd15;
    
    //horizontal segment sizing constraint (changable) 
    parameter segVsize2 = 10'd70;
    parameter segHsize2 = 10'd10;
    
    //Digit-Digit horizontal spacing
    parameter DDHSpace = 10'd20;
    
    //Digit-Colon horizontal spacing
    parameter DCHSpace = DDHSpace;
    
    //Colon sizing/spacing
    parameter ColonHSize = 10'd14;
    parameter ColonVSize = 10'd17;
    parameter ColonVoffset = 10'd200;
    parameter CCVoffset = 10'd60;
    
    //First Digit
    //vertical position parameter for segment a,d,g at Digit 1
    parameter SegD1AV1 = 10'd150;  //vertical position (top)
    parameter SegD1AV2 = SegD1AV1 + segVsize;
    
    //Digit 1 horizontal parameter for segment a,d,e,f,g
    parameter SegD1AH1 = 10'd50+Hbias;  //horizontal position(left)
    parameter SegD1AH2 = SegD1AH1 + segHsize; 
    
    //segment A Digit 1 digital mask
    assign Digit1SegA = ((~digit1[0])&&(vert_Cnt >= SegD1AV1)&&(vert_Cnt <= SegD1AV2)&&(horiz_Cnt >= SegD1AH1)&&(horiz_Cnt <= SegD1AH2));
    
    //segment A Digit 2 digital mask
    parameter D2SAH1 = SegD1AH2 + DDHSpace;
    parameter D2SAH2 = D2SAH1 + segHsize;
    assign Digit2SegA = ((~digit2[0])&&(vert_Cnt >= SegD1AV1)&&(vert_Cnt <= SegD1AV2)&&(horiz_Cnt >= D2SAH1)&&(horiz_Cnt <= D2SAH2));
    
    //Colon 1 digital mask
    parameter Colon1TopV2 = ColonVoffset + ColonVSize;
    parameter Colon1BotV1 = Colon1TopV2 + CCVoffset;
    parameter Colon1BotV2 = Colon1BotV1 + ColonVSize;
    parameter Colon1H1 = D2SAH2 + DCHSpace;
    parameter Colon1H2 = Colon1H1 + ColonHSize;
    assign colon1 = (((vert_Cnt >= ColonVoffset)&&(vert_Cnt <= Colon1TopV2)||(vert_Cnt >= Colon1BotV1)&&(vert_Cnt <= Colon1BotV2))&&(horiz_Cnt >= Colon1H1)&&(horiz_Cnt <= Colon1H2));
    
    //segment A Digit 3 digital mask
    parameter D3SAH1 = Colon1H2 + DCHSpace;
    parameter D3SAH2 = D3SAH1 + segHsize;
    assign Digit3SegA = ((~digit3[0])&&(vert_Cnt >= SegD1AV1)&&(vert_Cnt <= SegD1AV2)&&(horiz_Cnt >= D3SAH1)&&(horiz_Cnt <= D3SAH2));
    
    //segment A Digit 4 digital mask
    parameter D4SAH1 = D3SAH2 + DDHSpace;
    parameter D4SAH2 = D4SAH1 + segHsize;
    assign Digit4SegA = ((~digit4[0])&&(vert_Cnt >= SegD1AV1)&&(vert_Cnt <= SegD1AV2)&&(horiz_Cnt >= D4SAH1)&&(horiz_Cnt <= D4SAH2));
    
    //Colon 2 digital mask
    parameter Colon2H1 = D4SAH2 + DCHSpace;
    parameter Colon2H2 = Colon2H1 + ColonHSize;
    assign colon2 = (((vert_Cnt >= ColonVoffset)&&(vert_Cnt <= Colon1TopV2)||(vert_Cnt >= Colon1BotV1)&&(vert_Cnt <= Colon1BotV2))&&(horiz_Cnt >= Colon2H1)&&(horiz_Cnt <= Colon2H2));
    
    //segment A Digit 5 digital mask
    parameter D5SAH1 = Colon2H2 + DCHSpace;
    parameter D5SAH2 = D5SAH1 + segHsize;
    assign Digit5SegA = ((~digit5[0])&&(vert_Cnt >= SegD1AV1)&&(vert_Cnt <= SegD1AV2)&&(horiz_Cnt >= D5SAH1)&&(horiz_Cnt <= D5SAH2));
    
    //segment A Digit 6 digital mask
    parameter D6SAH1 = D5SAH2 + DDHSpace;
    parameter D6SAH2 = D6SAH1 + segHsize;
    assign Digit6SegA = ((~digit6[0])&&(vert_Cnt >= SegD1AV1)&&(vert_Cnt <= SegD1AV2)&&(horiz_Cnt >= D6SAH1)&&(horiz_Cnt <= D6SAH2));
    
    //segment B Digit 1 digital mask
    parameter SegD1BV = SegD1AV2 + segVsize2;
    parameter SegD1BH = SegD1AH2 - segHsize2;
    assign Digit1SegB = ((~digit1[1])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= SegD1BH)&&(horiz_Cnt <= SegD1AH2));
    
    //segment B Digit 2 digital mask
    parameter D2SBH1 = SegD1BH + DDHSpace + segHsize;
    parameter D2SBH2 = D2SBH1 + segHsize2;
    assign Digit2SegB = ((~digit2[1])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= D2SBH1)&&(horiz_Cnt <= D2SBH2));
    
    //segment B Digit 3 digital mask
    parameter D3SBH1 = Colon1H2 + DCHSpace + segHsize - segHsize2;
    parameter D3SBH2 = D3SBH1 + segHsize2;
    assign Digit3SegB = ((~digit3[1])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= D3SBH1)&&(horiz_Cnt <= D3SBH2));
    
    //segment B Digit 4 digital mask
    parameter D4SBH1 = D3SBH1 + DDHSpace + segHsize;
    parameter D4SBH2 = D4SBH1 + segHsize2;
    assign Digit4SegB = ((~digit4[1])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= D4SBH1)&&(horiz_Cnt <= D4SBH2));
    
    //segment B Digit 5 digital mask
    parameter D5SBH1 = Colon2H2 + DCHSpace + segHsize - segHsize2;
    parameter D5SBH2 = D5SBH1 + segHsize2;
    assign Digit5SegB = ((~digit5[1])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= D5SBH1)&&(horiz_Cnt <= D5SBH2));
    
    //segment B Digit 6 digital mask
    parameter D6SBH1 = D5SBH1 + DDHSpace + segHsize;
    parameter D6SBH2 = D6SBH1 + segHsize2;
    assign Digit6SegB = ((~digit6[1])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= D6SBH1)&&(horiz_Cnt <= D6SBH2));
    
    //segment F Digit 1 digital mask
    parameter SegD1FH = SegD1AH1 + segHsize2;
    assign Digit1SegF = ((~digit1[5])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= SegD1AH1)&&(horiz_Cnt <= SegD1FH));
    
    //segment F Digit 2 digital mask
    parameter D2SFH1 = SegD1AH1 + DDHSpace + segHsize;
    parameter D2SFH2 = D2SFH1 + segHsize2;
    assign Digit2SegF = ((~digit2[5])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= D2SFH1)&&(horiz_Cnt <= D2SFH2));
    
    //segment F Digit 3 digital mask
    parameter D3SFH1 = Colon1H2 + DCHSpace;
    parameter D3SFH2 = D3SFH1 + segHsize2;
    assign Digit3SegF = ((~digit3[5])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= D3SFH1)&&(horiz_Cnt <= D3SFH2));
    
    //segment F Digit 4 digital mask
    parameter D4SFH1 = D3SFH1 + DDHSpace + segHsize;
    parameter D4SFH2 = D4SFH1 + segHsize2;
    assign Digit4SegF = ((~digit4[5])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= D4SFH1)&&(horiz_Cnt <= D4SFH2));
    
    //segment F Digit 5 digital mask
    parameter D5SFH1 = Colon2H2 + DCHSpace;
    parameter D5SFH2 = D5SFH1 + segHsize2;
    assign Digit5SegF = ((~digit5[5])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= D5SFH1)&&(horiz_Cnt <= D5SFH2));
    
    //segment F Digit 6 digital mask
    parameter D6SFH1 = D5SFH1 + DDHSpace + segHsize;
    parameter D6SFH2 = D6SFH1 + segHsize2;
    assign Digit6SegF = ((~digit6[5])&&(vert_Cnt >= SegD1AV2)&&(vert_Cnt <= SegD1BV)&&(horiz_Cnt >= D6SFH1)&&(horiz_Cnt <= D6SFH2));
    
    //segment G Digit 1 digital mask
    parameter SegD1GV = SegD1BV + segVsize;
    assign Digit1SegG = ((~digit1[6])&&(vert_Cnt >= SegD1BV)&&(vert_Cnt <= SegD1GV)&&(horiz_Cnt >= SegD1AH1)&&(horiz_Cnt <= SegD1AH2));
    
    //segment G Digit 2 digital mask
    parameter D2SGH1 = SegD1AH2 + DDHSpace;
    parameter D2SGH2 = D2SGH1 + segHsize;
    assign Digit2SegG = ((~digit2[6])&&(vert_Cnt >= SegD1BV)&&(vert_Cnt <= SegD1GV)&&(horiz_Cnt >= D2SGH1)&&(horiz_Cnt <= D2SGH2));
    
    //segment G Digit 3 digital mask
    assign Digit3SegG = ((~digit3[6])&&(vert_Cnt >= SegD1BV)&&(vert_Cnt <= SegD1GV)&&(horiz_Cnt >= D3SAH1)&&(horiz_Cnt <= D3SAH2));
    
    //segment G Digit 4 digital mask
    assign Digit4SegG = ((~digit4[6])&&(vert_Cnt >= SegD1BV)&&(vert_Cnt <= SegD1GV)&&(horiz_Cnt >= D4SAH1)&&(horiz_Cnt <= D4SAH2));
    
    //segment G Digit 5 digital mask
    assign Digit5SegG = ((~digit5[6])&&(vert_Cnt >= SegD1BV)&&(vert_Cnt <= SegD1GV)&&(horiz_Cnt >= D5SAH1)&&(horiz_Cnt <= D5SAH2));
    
    //segment G Digit 6 digital mask
    assign Digit6SegG = ((~digit6[6])&&(vert_Cnt >= SegD1BV)&&(vert_Cnt <= SegD1GV)&&(horiz_Cnt >= D6SAH1)&&(horiz_Cnt <= D6SAH2));
    
    //segment C Digit 1 digital mask
    parameter SegD1CV = SegD1GV + segVsize2;
    assign Digit1SegC = ((~digit1[2])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= SegD1BH)&&(horiz_Cnt <= SegD1AH2));
    
    //segment C Digit 2 digital mask
    assign Digit2SegC = ((~digit2[2])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= D2SBH1)&&(horiz_Cnt <= D2SBH2));
    
    //segment C Digit 3 digital mask
    assign Digit3SegC = ((~digit3[2])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= D3SBH1)&&(horiz_Cnt <= D3SBH2));
    
    //segment C Digit 4 digital mask
    assign Digit4SegC = ((~digit4[2])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= D4SBH1)&&(horiz_Cnt <= D4SBH2));
    
    //segment C Digit 5 digital mask
    assign Digit5SegC = ((~digit5[2])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= D5SBH1)&&(horiz_Cnt <= D5SBH2));
    
    //segment C Digit 6 digital mask
    assign Digit6SegC = ((~digit6[2])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= D6SBH1)&&(horiz_Cnt <= D6SBH2));
    
    //segment E Digit 1 digital mask
    assign Digit1SegE = ((~digit1[4])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= SegD1AH1)&&(horiz_Cnt <= SegD1FH));
    
    //segment E Digit 2 digital mask
    assign Digit2SegE = ((~digit2[4])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= D2SFH1)&&(horiz_Cnt <= D2SFH2));
    
    //segment E Digit 3 digital mask
    assign Digit3SegE = ((~digit3[4])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= D3SFH1)&&(horiz_Cnt <= D3SFH2));
    
    //segment E Digit 4 digital mask
    assign Digit4SegE = ((~digit4[4])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= D4SFH1)&&(horiz_Cnt <= D4SFH2));
    
    //segment E Digit 5 digital mask
    assign Digit5SegE = ((~digit5[4])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= D5SFH1)&&(horiz_Cnt <= D5SFH2));
    
    //segment E Digit 6 digital mask
    assign Digit6SegE = ((~digit6[4])&&(vert_Cnt >= SegD1GV)&&(vert_Cnt <= SegD1CV)&&(horiz_Cnt >= D6SFH1)&&(horiz_Cnt <= D6SFH2));
    
    //segment D Digit 1 digital mask
    parameter SegD1DV = SegD1CV + segVsize;
    assign Digit1SegD = ((~digit1[3])&&(vert_Cnt >= SegD1CV)&&(vert_Cnt <= SegD1DV)&&(horiz_Cnt >= SegD1AH1)&&(horiz_Cnt <= SegD1AH2));
    
    //segment D Digit 2 digital mask
    parameter D2SDH1 = SegD1AH2 + DDHSpace;
    parameter D2SDH2 = D2SDH1 + segHsize;
    assign Digit2SegD = ((~digit2[3])&&(vert_Cnt >= SegD1CV)&&(vert_Cnt <= SegD1DV)&&(horiz_Cnt >= D2SDH1)&&(horiz_Cnt <= D2SDH2));
    
    //segment D Digit 3 digital mask
    assign Digit3SegD = ((~digit3[3])&&(vert_Cnt >= SegD1CV)&&(vert_Cnt <= SegD1DV)&&(horiz_Cnt >= D3SAH1)&&(horiz_Cnt <= D3SAH2));
    
    //segment D Digit 4 digital mask
    assign Digit4SegD = ((~digit4[3])&&(vert_Cnt >= SegD1CV)&&(vert_Cnt <= SegD1DV)&&(horiz_Cnt >= D4SAH1)&&(horiz_Cnt <= D4SAH2));
    
    //segment D Digit 5 digital mask
    assign Digit5SegD = ((~digit5[3])&&(vert_Cnt >= SegD1CV)&&(vert_Cnt <= SegD1DV)&&(horiz_Cnt >= D5SAH1)&&(horiz_Cnt <= D5SAH2));
    
    //segment D Digit 6 digital mask
    assign Digit6SegD = ((~digit6[3])&&(vert_Cnt >= SegD1CV)&&(vert_Cnt <= SegD1DV)&&(horiz_Cnt >= D6SAH1)&&(horiz_Cnt <= D6SAH2));
    
endmodule
