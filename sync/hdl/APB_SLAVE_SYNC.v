`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:21:28 02/20/2014 
// Design Name: 
// Module Name:    APB_SLAVE_SYNC 
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

module APB_SLAVE_SYNC #
  (
                parameter DWIDTH = 32,
                parameter AWIDTH = 32           
  )
  (
        input                           PCLK,
        input                           PRESETn,
        input                           PSEL,
        input                           PWRITE,
        input                           PENABLE,
        input           [DWIDTH-1:0]    PWDATA, 
        
        output reg      [DWIDTH-1:0]    PRDATA,
        output                          PREADY,
        output                          PSLVERR,
        input           [AWIDTH-1:0]    PADDR   
  );

        integer i;

        reg [DWIDTH-1:0]        data_r [7:0];
        
        assign wr_en    = (PENABLE && PWRITE && PSEL);
        assign rd_en    = (!PWRITE && PSEL); 
        
        assign PREADY   = 1'b1;
        assign PSLVERR = 1'b0;

        always@(posedge PCLK or negedge PRESETn) begin
                if (!PRESETn) begin
                        PRDATA <= {DWIDTH{1'b0}};
                end else if (rd_en) begin
                        PRDATA <= data_r[PADDR[7:0]];
                end
        end
        
        always@(posedge PCLK or negedge PRESETn) begin
                if (!PRESETn) begin
                        for (i=0; i<8; i=i+1) begin : reset_gen
                                data_r[i] <= {DWIDTH{1'b0}};
                        end
                end else if (wr_en) begin
                        data_r[8'h0] <= PWDATA;
                end
        end
        
endmodule
