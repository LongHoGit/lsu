module demux_1to8 (
  //input
  input  logic [31:0]      data_i,
  input  logic [2:0]       sel_i,

  //output
  output logic [7:0][31:0] data_o
);

  always_ff @(data_i or sel_i)
    begin
      case (sel_i)
      3'd0:begin
             data_o[0]   = data_i;
             data_o[7:1] = 32'd0;
           end

      3'd1:begin
      	    data_o[1]   = data_i;
             data_o[7:2] = 32'd0;
             data_o[0]   = 32'd0;
           end 

      3'd2:begin
             data_o[2]   = data_i;
             data_o[7:3] = 32'd0;
             data_o[1:0] = 32'd0;
           end

      3'd3:begin
             data_o[3]   = data_i;
             data_o[7:4] = 32'd0;
             data_o[2:0] = 32'd0;
           end 

      3'd4:begin
             data_o[4]   = data_i;
             data_o[7:5] = 32'd0;
             data_o[3:0] = 32'd0;
           end 

      3'd5:begin
             data_o[5]   = data_i;
             data_o[7:6] = 32'd0;
             data_o[4:0] = 32'd0;
           end

      3'd6:begin
             data_o[6]   = data_i;
             data_o[7]   = 32'd0;
             data_o[5:0] = 32'd0;
           end 

      3'd7:begin
             data_o[7]   = data_i;
             data_o[6:0] = 32'd0;
           end

      endcase
    end

endmodule : demux_1to8