`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:45:26 02/20/2014 
// Design Name: 
// Module Name:    APB_SLAVE_ASYNC 
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


module APB_SLAVE_ASYNC #
  (
        parameter DWIDTH = 32,
        parameter AWIDTH = 32           
  )
  (
        output                  PREADY,
        output   [DWIDTH-1:0]   PRDATA,
        
        input    [AWIDTH-1:0]   PADDR,
        input    [DWIDTH-1:0]   PWDATA,
        input                   PWRITE,
        input                   PSEL,
        input                   PENABLE
  );


        
        
endmodule
