module mux_8to1 (
  //input
  input logic  [7:0][31:0] data_i,
  input logic  [2:0]  sel_i,

  //data_oput
  output logic [31:0] data_o
);

  always_ff @(sel_i or data_i[0] or data_i[1] or data_i[2] or data_i[3] or data_i[4] or data_i[5] or data_i[6] or data_i[7])
  begin
    case (sel_i)
        3'd0:data_o = data_i[0];
        3'd1:data_o = data_i[1];
        3'd2:data_o = data_i[2];
        3'd3:data_o = data_i[3];
        3'd4:data_o = data_i[4];
        3'd5:data_o = data_i[5];
        3'd6:data_o = data_i[6];
     default:data_o = data_i[7];
    endcase
  end
endmodule : mux_8to1