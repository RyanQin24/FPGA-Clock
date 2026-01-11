`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2026 07:46:00 PM
// Design Name: 
// Module Name: Horiz_Counter
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


module Horiz_Counter(
    input clock_25_mhz,
    output wire [9:0] hcount,
    output vert_clock
    );
    reg [9:0] Hcounter = 0;
    reg clock = 0;
    assign hcount = Hcounter;
    assign vert_clock = clock;
    always @(posedge clock_25_mhz) begin
        if(Hcounter == 799) begin
            clock <= ~clock;
            Hcounter <= 0;
        end else begin
            Hcounter <= Hcounter + 1;
        end
    end
    
endmodule
