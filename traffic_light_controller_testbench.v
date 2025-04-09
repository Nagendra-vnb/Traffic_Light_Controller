`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2025 11:28:18 AM
// Design Name: 
// Module Name: traffic_light_controller_testbench
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

module traffic_light_controller_testbench;
wire [1:0] main_signal,country_signal;
reg car_on_country_road;
reg clock,clear;
parameter true=1'b1;
parameter false = 1'b0;
traffic_light_controller TLC1(.highway_road(main_signal),.country_road(country_signal),.x(car_on_country_road),.clk(clock),.clear(clear));
initial
    $monitor($time,"main_signal=%b country_signal = %b car_on_country_road = %b",main_signal,country_signal,car_on_country_road);
initial
begin
    clock = false;
    forever #5 clock = ~clock;
end
initial
begin
car_on_country_road = false;
repeat(20)@(negedge clock);
car_on_country_road = true;
repeat(10)@(negedge clock);
car_on_country_road = false;
repeat(20)@(negedge clock);
car_on_country_road = true;
repeat(10)@(negedge clock);
#20;
$stop;
end
endmodule
