`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 03:51:16 PM
// Design Name: 
// Module Name: Clock_Counter
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


module Clock_Counter(
    input clk_100MHZ,
    input wire [4:0] pb,
    input wire [15:0] switch,
    output wire [7:0] seg,
    output wire [15:0] leds,
    output wire [3:0] anode,
    output hsync,
    output vsync,
    output wire [3:0] VGA_Red,
    output wire [3:0] VGA_Green,
    output wire [3:0] VGA_Blue
    );
    
    //wire and register definition
    wire clk_1Hz;
    wire [6:0] seg1;
    wire [6:0] seg2;
    wire [6:0] seg3;
    wire [6:0] seg4;
    wire [6:0] seg5;
    wire [6:0] seg6;
    
    wire [9:0] vertcnt;
    wire [9:0] horizcnt;
    wire drive_enable;
    
    reg [3:0] sec_ones;
    reg [3:0] sec_tens;
    reg [3:0] mins_ones;
    reg [3:0] mins_tens;
    reg [3:0] hours_ones;
    reg [3:0] hours_tens;
    
    //pin assignments
    assign leds[3:0] = sec_ones;
    assign leds[7:4] = sec_tens;
    
    //module declaration
    Clock_Divider inst0(.clk_100MHZ(clk_100MHZ), .clk_1Hz(clk_1Hz));
    Seven_Seg_Mux inst1 (.clock(clk_100MHZ),.decimal_place_1(1'b0),.decimal_place_2(clk_1Hz),.decimal_place_3(1'b0),.decimal_place_4(1'b0),.dig1(seg1),.dig2(seg2),.dig3(seg3),.dig4(seg4),.dig_out(seg),.anode(anode));
    Decoder inst2 (.number(hours_tens),.seg(seg1));
    Decoder inst3 (.number(hours_ones),.seg(seg2));
    Decoder inst4 (.number(mins_tens),.seg(seg3));
    Decoder inst5 (.number(mins_ones),.seg(seg4));
    Decoder inst6 (.number(sec_tens),.seg(seg5));
    Decoder inst7 (.number(sec_ones),.seg(seg6));
    VGA_Driver inst8(.clock_100mhz(clk_100MHZ),.red_color(switch[15:12]),.green_color(switch[11:8]),.blue_color(switch[7:4]),.drive_enable(drive_enable),.vsync(vsync),.hsync(hsync),.drive_Red(VGA_Red),.drive_Green(VGA_Green),.drive_Blue(VGA_Blue),.Hcnt(horizcnt),.Vcnt(vertcnt));
    VGA_Decoder inst9(.vert_Cnt(vertcnt),.digit1(seg1),.digit2(seg2),.digit3(seg3),.digit4(seg4),.digit5(seg5),.digit6(seg6),.horiz_Cnt(horizcnt),.drive_enable(drive_enable));
    //counter process
    always @(posedge clk_1Hz) begin
        if(pb[2]) begin
            hours_ones <= hours_ones + 1;
            if ((hours_tens == 2) && (hours_ones == 3)) begin
                hours_ones <= 0;
                hours_tens <= 0;
           end else if(hours_ones == 9) begin
                hours_ones <= 0;
                hours_tens <= hours_tens + 1;
           end
        end else if(pb[1]) begin
            mins_ones <= mins_ones + 1;
            if ((mins_tens == 5) && (mins_ones == 9)) begin
                mins_ones <= 0;
                mins_tens <= 0;
            end else if(mins_ones == 9) begin
                mins_ones <= 0;
                mins_tens <= mins_tens + 1;
            end
        end else begin
            if ((sec_tens == 5) && (sec_ones == 9)) begin
                sec_ones <= 0;
                sec_tens <= 0;
                mins_ones <= mins_ones + 1;
                if ((mins_tens == 5) && (mins_ones == 9)) begin
                    mins_ones <= 0;
                    mins_tens <= 0;
                    hours_ones <= hours_ones + 1;
                    if ((hours_tens == 2) && (hours_ones == 3)) begin
                        hours_ones <= 0;
                        hours_tens <= 0;
                    end else if(hours_ones == 9) begin
                        hours_ones <= 0;
                        hours_tens <= hours_tens + 1;
                    end
                end else if(mins_ones == 9) begin
                    mins_ones <= 0;
                    mins_tens <= mins_tens + 1;
                end
            end else if(sec_ones == 9) begin
                sec_ones <= 0;
                sec_tens <= sec_tens + 1;
            end else begin
                sec_ones <= sec_ones + 1;
            end
        
        end
    end
endmodule
