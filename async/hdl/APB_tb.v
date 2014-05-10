`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:41:13 02/21/2014
// Design Name:   APB_TOP
// Module Name:   D:/APB/APB_tb.v
// Project Name:  APB
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: APB_TOP
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module APB_tb;

	// Inputs
	reg rst_n;
	reg TRANSFER;
	reg [31:0] PADDR;
	reg [31:0] PWDATA;
	reg PWRITE;

	// Outputs
	wire [31:0] PRDATA;

	// Instantiate the Unit Under Test (UUT)
	APB_TOP uut (
		.rst_n(rst_n), 
		.TRANSFER(TRANSFER), 
		.PADDR(PADDR), 
		.PWDATA(PWDATA), 
		.PRDATA(PRDATA), 
		.PWRITE(PWRITE)
	);

	initial begin
		// Initialize Inputs
		rst_n = 0;
		TRANSFER = 0;
		PADDR = 0;
		PWDATA = 0;
		PWRITE = 0;

		#100;
		rst_n = 0;
		#100;
		rst_n = 1;
		#90
		//Perform write
		TRANSFER = 1;
		PWRITE = 1;
		PADDR = 9'h100;
		//Setup state
		#20
		//Access state
		#20
		TRANSFER = 0;
		PWRITE = 0;
		#100 $finish();
        

	end
      
endmodule

