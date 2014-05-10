
module testbench ( PRESETn, TRANSFER, PREADY, PRDATA, PSEL, PENABLE );
  input [31:0] PRDATA;
  input PRESETn, TRANSFER, PREADY;
  output PSEL, PENABLE;
  wire   n1;
  assign PENABLE = 1'b0;

  AO21_I U2 ( .A1(n1), .A2(PSEL), .B(TRANSFER), .Z(PSEL) );
  INVERTBAL_E U5 ( .A(PREADY), .Z(n1) );
endmodule

