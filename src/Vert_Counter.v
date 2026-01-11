`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2026 07:45:37 PM
// Design Name: 
// Module Name: Vert_Counter
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


module Vert_Counter(
    input vert_clock,
    output wire [9:0] vcount
    );
    
    reg  [9:0] Vcounter = 0;
    assign vcount = Vcounter;
    always @(posedge vert_clock) begin
        if(Vcounter == 524) begin
            Vcounter <= 0;
        end else begin
            Vcounter <= Vcounter + 1;
        end
    end
endmodule
