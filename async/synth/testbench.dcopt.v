
module testbench ( PRESETn, TRANSFER, PREADY, PRDATA, PSEL, PENABLE );
  input [31:0] PRDATA;
  input PRESETn, TRANSFER, PREADY;
  output PSEL, PENABLE;
  wire   zzz00, n2, n3, n4;

  OA21_I U3 ( .A1(zzz00), .A2(TRANSFER), .B(PREADY), .Z(zzz00) );
  AOI21_E U5 ( .A1(n2), .A2(PSEL), .B(zzz00), .Z(n3) );
  INVERTBAL_E U8 ( .A(PREADY), .Z(n2) );
  NAND2_A U9 ( .A(n3), .B(n4), .Z(PSEL) );
  INVERTBAL_E U10 ( .A(TRANSFER), .Z(n4) );
  NOR2_A U11 ( .A(n3), .B(TRANSFER), .Z(PENABLE) );
endmodule

