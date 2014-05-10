`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:38:53 02/20/2014 
// Design Name: 
// Module Name:    APB_TOP 
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
module APB_TOP #
   (
        parameter AWIDTH = 32,
        parameter DWIDTH = 32
   
   (
        input                   rst_n,
        input                   TRANSFER,
        input  [AWIDTH-1:0]     PADDR,
        input  [DWIDTH-1:0]     PWDATA,
        output [DWIDTH-1:0]     PRDATA,
        input                   PWRITE
    );

                
        wire PREADY,PSEL,PENABLE;

        APB_MASTER_ASYNC 
        #(
                .DWIDTH(DWIDTH),
                .AWIDTH(AWIDTH)
        )
        APB_MASTER_INST
        (
                .PRESETn(rst_n),
                .TRANSFER(TRANSFER),
                .PRDATA(PRDATA),        
                .PREADY(PREADY),
                .PSEL(PSEL), 
                .PENABLE(PENABLE)
        );

/*        APB_SLAVE_SYNC 
        #(
                .DWIDTH(DWIDTH),
                .AWIDTH(AWIDTH)
        )
        APB_SLAVE_INST
        (
                .PRESETn(rst_n),
                .PRDATA(PRDATA),
                .PWDATA(PWDATA),
                .PADDR(PADDR),
                .PREADY(PREADY),
                .PWRITE(PWRITE),
                .PSEL(PADDR[8]),
                .PENABLE(PENABLE)
        );
*/
endmodule
