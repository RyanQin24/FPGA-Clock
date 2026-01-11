`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/06/2026 11:08:16 AM
// Design Name: 
// Module Name: VGA_Driver
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


module VGA_Driver(
    input clock_100mhz,
    input wire [3:0] red_color,
    input wire [3:0] green_color,
    input wire [3:0] blue_color,
    input drive_enable,
    output vsync,
    output hsync,
    output wire [3:0] drive_Red,
    output wire [3:0] drive_Blue,
    output wire [3:0] drive_Green,
    output wire [9:0] Hcnt,
    output wire [9:0] Vcnt
    );
    wire clock_25mhz;
    wire [9:0] horizcnt;
    wire [9:0] vertcnt;
    wire vert_clk;
    Clock_Divider_VGA inst0(.clk_100MHZ(clock_100mhz), .clk_25MHz(clock_25mhz));
    Horiz_Counter inst1 (.clock_25_mhz(clock_25mhz),.hcount(horizcnt),.vert_clock(vert_clk));
    Vert_Counter inst2 (.vert_clock(vert_clk),.vcount(vertcnt));
    
    parameter Hsync_on = 10'd0;  
    parameter Hsync_off = 10'd96;
    parameter Hdisplay_on = 10'd144;  
    parameter Hdisplay_off = 10'd784; 
    parameter Vsync_on = 10'd0;  
    parameter Vsync_off = 10'd2;
    
    assign Hcnt = horizcnt;
    assign Vcnt = vertcnt;
    
    assign hsync = ~((horizcnt >= Hsync_on)&&(horizcnt <= Hsync_off));
    assign vsync = ~((vertcnt >= Vsync_on)&&(vertcnt <= Vsync_off));
    
    assign drive_Red = (drive_enable && (horizcnt >= Hdisplay_on)&&(horizcnt <= Hdisplay_off)) ? red_color : 4'b0000;
    assign drive_Blue = (drive_enable && (horizcnt >= Hdisplay_on)&&(horizcnt <= Hdisplay_off)) ? blue_color : 4'b0000;
    assign drive_Green = (drive_enable && (horizcnt >= Hdisplay_on)&&(horizcnt <= Hdisplay_off)) ? green_color : 4'b0000;
    
endmodule
