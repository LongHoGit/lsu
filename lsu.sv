module lsu (
  //input
  input logic         clk_i, 
  input logic         rst_ni,
  input logic  [10:0] addr_i, 
  input logic  [31:0] st_data_i,
  input logic         st_en,
  input logic  [17:0] io_sw_i,

  //output
  output logic [31:0] ld_data_o,
  output logic [31:0] io_lcd_o,
  output logic [31:0] io_ledg_o,
  output logic [31:0] io_ledr_o,
  output logic [31:0] io_hex_o[7:0]
);
  //demux to data_mem, external_mem
  logic  [31:0] data;
  logic  [2:0]  addr_sel; //select data mem or periheral mem

  assign addr_sel = addr_i[10:8];

  //data_mem, external_mem to mux
  logic  [7:0][31:0] r_data;

  assign r_data[7:6] = 32'b0;

  //extend bit io_sw_i
  logic [31:0] io_sw;
  
  assign io_sw = {14'b00000000000000,io_sw_i};
  
//all sub-module
  demux_1to8 demux_u0  (
                       //input
                       .data_i (st_data_i   ),
                       .sel_i  (addr_sel    ),

                       //output
                       .data_o (data        )
                       );

//data memory
  data_mem data_mem_u0 (
                       //input
                       .rst_ni  (rst_ni     ),
                       .clk_i   (clk_i      ),
                       .addr_i  (addr_i[7:0]), //memory addr_i
                       .wdata_i (data       ), //the write data
                       .wren_i  (st_en      ), //write enable

                       //output
                       .r_data_o(r_data[0]  ) //the read data
                       );

  data_mem data_mem_u1 (
                       //input
                       .rst_ni  (rst_ni     ),
                       .clk_i   (clk_i      ),
                       .addr_i  (addr_i[7:0]), //memory addr_i
                       .wdata_i (data       ), //the write data
                       .wren_i  (st_en      ), //write enable

                       //output
                       .r_data_o(r_data[1]  ) //the read data
                       );

  data_mem data_mem_u2 (
                       //input
                       .rst_ni  (rst_ni     ),
                       .clk_i   (clk_i      ),
                       .addr_i  (addr_i[7:0]), //memory addr_i
                       .wdata_i (data       ), //the write data
                       .wren_i  (st_en      ), //write enable

                       //output
                       .r_data_o(r_data[2]  ) //the read data
                       );

  data_mem data_mem_u3 (
                       //input
                       .rst_ni  (rst_ni     ),
                       .clk_i   (clk_i      ),
                       .addr_i  (addr_i[7:0]), //memory addr_i
                       .wdata_i (data       ), //the write data
                       .wren_i  (st_en      ), //write enable

                       //output
                       .r_data_o(r_data[3]  ) //the read data
                       );

//peripheral output
  data_mem peri_o_u0   (
                       //input
                       .rst_ni  (rst_ni     ),
                       .clk_i   (clk_i      ),
                       .addr_i  (addr_i[7:0]), //memory addr_i
                       .wdata_i (data       ), //the write data
                       .wren_i  (st_en      ), //write enable

                       //output
                       .r_data_o(r_data[4]  )  //the read data
                       );

//peripheral input
  data_mem peri_i_u0   (
                       //input
                       .rst_ni  (rst_ni     ),
                       .clk_i   (clk_i      ),
                       .addr_i  (addr_i[7:0]), //memory addr_i
                       .wdata_i (io_sw      ), //the write data
                       .wren_i  (st_en      ), //write enable

                       //output
                       .r_data_o(r_data[5]  )  //the read data
                       );

  mux_8to1 mux_u0      (
                       //input
                       .data_i  (r_data     ),
                       .sel_i   (addr_sel   ),

                       //data_oput
                       .data_o  (ld_data_o  )
                       );

  always_ff @(addr_i[10:4] or r_data[4]) 
    begin
          case (addr_i[10:4])
            7'h40:
            begin
              io_hex_o[0] = r_data[4];
              io_hex_o[1] = 0;
              io_hex_o[2] = 0;
              io_hex_o[3] = 0;
              io_hex_o[4] = 0;
              io_hex_o[5] = 0;
              io_hex_o[6] = 0;
              io_hex_o[7] = 0;
              io_ledr_o   = 0;
              io_ledg_o   = 0;
              io_lcd_o    = 0;
            end

            7'h41:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = r_data[4];
              io_hex_o[2] = 0;
              io_hex_o[3] = 0;
              io_hex_o[4] = 0;
              io_hex_o[5] = 0;
              io_hex_o[6] = 0;
              io_hex_o[7] = 0;
              io_ledr_o   = 0;
              io_ledg_o   = 0;
              io_lcd_o    = 0;
            end

            7'h42:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = 0;
              io_hex_o[2] = r_data[4];
              io_hex_o[3] = 0;
              io_hex_o[4] = 0;
              io_hex_o[5] = 0;
              io_hex_o[6] = 0;
              io_hex_o[7] = 0;
              io_ledr_o   = 0;
              io_ledg_o   = 0;
              io_lcd_o    = 0;
            end

            7'h43:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = 0;
              io_hex_o[2] = 0;
              io_hex_o[3] = r_data[4];
              io_hex_o[4] = 0;
              io_hex_o[5] = 0;
              io_hex_o[6] = 0;
              io_hex_o[7] = 0;
              io_ledr_o   = 0;
              io_ledg_o   = 0;
              io_lcd_o    = 0;
            end

            7'h44:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = 0;
              io_hex_o[2] = 0;
              io_hex_o[3] = 0;
              io_hex_o[4] = r_data[4];
              io_hex_o[5] = 0;
              io_hex_o[6] = 0;
              io_hex_o[7] = 0;
              io_ledr_o   = 0;
              io_ledg_o   = 0;
              io_lcd_o    = 0;
            end

            7'h45:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = 0;
              io_hex_o[2] = 0;
              io_hex_o[3] = 0;
              io_hex_o[4] = 0;
              io_hex_o[5] = r_data[4];
              io_hex_o[6] = 0;
              io_hex_o[7] = 0;
              io_ledr_o   = 0;
              io_ledg_o   = 0;
              io_lcd_o    = 0;
            end
            
            7'h46:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = 0;
              io_hex_o[2] = 0;
              io_hex_o[3] = 0;
              io_hex_o[4] = 0;
              io_hex_o[5] = 0;
              io_hex_o[6] = r_data[4];
              io_hex_o[7] = 0;
              io_ledr_o   = 0;
              io_ledg_o   = 0;
              io_lcd_o    = 0;
            end

            7'h47:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = 0;
              io_hex_o[2] = 0;
              io_hex_o[3] = 0;
              io_hex_o[4] = 0;
              io_hex_o[5] = 0;
              io_hex_o[6] = 0;
              io_hex_o[7] = r_data[4];
              io_ledr_o   = 0;
              io_ledg_o   = 0;
              io_lcd_o    = 0;
            end

            7'h48:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = 0;
              io_hex_o[2] = 0;
              io_hex_o[3] = 0;
              io_hex_o[4] = 0;
              io_hex_o[5] = 0;
              io_hex_o[6] = 0;
              io_hex_o[7] = 0;
              io_ledr_o   = r_data[4];
              io_ledg_o   = 0;
              io_lcd_o    = 0;
            end

            7'h49:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = 0;
              io_hex_o[2] = 0;
              io_hex_o[3] = 0;
              io_hex_o[4] = 0;
              io_hex_o[5] = 0;
              io_hex_o[6] = 0;
              io_hex_o[7] = 0;
              io_ledr_o   = 0;
              io_ledg_o   = r_data[4];
              io_lcd_o    = 0;
            end

            7'h4a:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = 0;
              io_hex_o[2] = 0;
              io_hex_o[3] = 0;
              io_hex_o[4] = 0;
              io_hex_o[5] = 0;
              io_hex_o[6] = 0;
              io_hex_o[7] = 0;
              io_ledr_o   = 0;
              io_ledg_o   = 0;
              io_lcd_o    = r_data[4];
            end

            default:
            begin
              io_hex_o[0] = 0;
              io_hex_o[1] = 0;
              io_hex_o[2] = 0;
              io_hex_o[3] = 0;
              io_hex_o[4] = 0;
              io_hex_o[5] = 0;
              io_hex_o[6] = 0;
              io_hex_o[7] = 0;
              io_ledr_o   = 0;
              io_ledg_o   = 0;
              io_lcd_o    = 0;
            end
          endcase
    end
endmodule : lsu