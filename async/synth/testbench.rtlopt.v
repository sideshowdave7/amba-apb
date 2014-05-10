
module testbench ( PRESETn, TRANSFER, PREADY, PRDATA, PSEL, PENABLE );
  input [31:0] PRDATA;
  input PRESETn, TRANSFER, PREADY;
  output PSEL, PENABLE;
  wire   PREADYn, TRANSFERn, zzz00, psel_and_transfern;

  INVERT_C inv_i0 ( .A(PREADY), .Z(PREADYn) );
  INVERT_C inv_i1 ( .A(TRANSFER), .Z(TRANSFERn) );
  AO222_C AO_i0 ( .A1(TRANSFER), .A2(1'b1), .B1(zzz00), .B2(1'b1), .C1(PREADYn), .C2(PSEL), .Z(PSEL) );
  AND2_C AND_i0 ( .A(TRANSFERn), .B(PSEL), .Z(psel_and_transfern) );
  AO22_C AO_i1 ( .A1(TRANSFERn), .A2(zzz00), .B1(PREADYn), .B2(
        psel_and_transfern), .Z(PENABLE) );
  AO22_C AO_i2 ( .A1(PREADY), .A2(TRANSFER), .B1(PREADY), .B2(zzz00), .Z(zzz00) );
endmodule

