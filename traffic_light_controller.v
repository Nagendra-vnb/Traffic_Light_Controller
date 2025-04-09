`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2025 10:49:40 AM
// Design Name: 
// Module Name: traffic_light_controller
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

 
module traffic_light_controller(
    output reg [1:0] highway_road,
    output reg [1:0] country_road,
    input x,
    input clk,
    input clear
    );
parameter red = 2'd0 , yellow = 2'd1 , green = 2'd2 ;
parameter S0 = 3'd0 , S1 = 3'd1 , S2 = 3'd2 , S3 = 3'd3 , S4 = 3'd4;
reg [2:0] state;
reg [2:0] next_state;
parameter  Y2Rdelay =3'b011;
parameter  R2Gdelay= 3'b010;
always@(posedge clk)
    if (clear)
        state<= S0;
    else
        state<= next_state;
always@(state)
begin
    highway_road = green;
    country_road = red;
    case(state)
        S0 : begin
             highway_road = green;
             country_road = red;
             end
        S1 : highway_road = yellow ;
        S2 : highway_road = red;
        S3 :begin
            highway_road = red;
            country_road = green;
            end
        S4:begin
           highway_road = red;
           country_road = yellow;
           end 
    endcase
end
always@(state or x)
begin
    case(state)
    S0: if (x)
            next_state = S1;
        else
            next_state = S0;
    S1: begin 
        repeat(Y2Rdelay)@(posedge clk)
        next_state = S2;
        end
    S2: begin
        repeat(R2Gdelay)@(posedge clk)
        next_state = S3;
        end
    S3: if (x) 
        next_state = S3;
        else
        next_state = S4;
    S4: begin
        repeat(Y2Rdelay)@(posedge clk)
        next_state = S0;
        end
    default:next_state = S0;
    endcase
end
endmodule
