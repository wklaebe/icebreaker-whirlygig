`default_nettype none

`include "led-simple.v"
`include "whirlygig.v"

module top (
        input         CLK,
        input         BTN_N,
        output [15:0] LED_PANEL);

    led_main led_main (
        .CLK(CLK),
        .resetn_btn(BTN_N),
        .LED_PANEL(LED_PANEL));

endmodule


module painter(
        input        clk,
        input        reset,
        input [12:0] frame,
        input  [7:0] subframe,
        input  [5:0] x,
        input  [5:0] y,
        output reg [2:0] rgb);

    whirlygig #(.cCountResultWidth(3)) whirlygig_inst(
        .clk(clk),
        .out(rnd));

    wire [2:0] rnd;

    always @(clk) begin
        case(subframe)
            0:
                rgb <= rnd;
            default:
                rgb <= 3'd0;
        endcase
    end

endmodule
