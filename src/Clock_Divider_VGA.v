`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2026 07:36:37 PM
// Design Name: 
// Module Name: Clock_Divider_VGA
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


module Clock_Divider_VGA(
    input clk_100MHZ,
    output clk_25MHz
    );
    
    reg counter = 0;
    reg clock = 0;
    
    assign clk_25MHz = clock;
    
    always @(posedge clk_100MHZ) begin
        if (counter == 1) begin
            counter <= 0;
            clock = ~clock;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule
