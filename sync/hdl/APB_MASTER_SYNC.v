`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:45:26 02/20/2014 
// Design Name: 
// Module Name:    APB_MASTER_SYNC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`include "defines.vh"

module APB_MASTER_SYNC #
  (
		parameter DWIDTH = 32,
		parameter AWIDTH = 32		
  )
  (
	input							PCLK,
	input							PRESETn,
	input							PSLVERR,
	input							TRANSFER,
	input							PREADY,
	input		[DWIDTH-1:0]	PRDATA,
	
	output reg  				PSEL_EN, 
	output reg					PENABLE
  );


	localparam ST_IDLE   = 2'b00;
	localparam ST_SETUP  = 2'b01;
	localparam ST_ACCESS = 2'b10;

	reg  [1:0]		STATE;
	reg  [1:0]		NEXT;
	
	
	always@(posedge PCLK or negedge PRESETn) begin
		if (!PRESETn) begin
			STATE <= ST_IDLE;
		end else begin
			STATE <= NEXT;
		end
	end
	
	always@(STATE or TRANSFER or PREADY) begin
		NEXT = ST_IDLE;
		case(STATE)
			ST_IDLE: begin
				if (TRANSFER)
					NEXT = ST_SETUP;
			end
			ST_SETUP: begin
				NEXT = ST_ACCESS;
			end
			ST_ACCESS: begin
				if (PREADY && TRANSFER)
					NEXT = ST_SETUP;
				else if (PREADY && ~TRANSFER)
					NEXT = ST_IDLE;
			end
		endcase
	end
		
	always@(posedge PCLK or negedge PRESETn) begin	
		if (!PRESETn) begin
			PENABLE <= 1'b0;
			PSEL_EN <= 1'b0;
		end else begin
			PENABLE <= 1'b0;
			PSEL_EN <= 1'b0;
			case(NEXT)		
				ST_SETUP: begin
					PSEL_EN <= 1'b1;
				end
				ST_ACCESS: begin
					PSEL_EN <= 1'b1;
					PENABLE <= 1'b1;
				end
			endcase
		end
	end
	
endmodule
