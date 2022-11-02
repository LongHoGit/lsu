module data_mem (
  //input
  input  logic        rst_ni,
  input  logic        clk_i,
  input  logic [7:0]  addr_i,// memory addr_i
  input  logic [31:0] wdata_i, //the write data
  input  logic        wren_i, //write enable

  //output
  output logic [31:0] r_data_o //the read data
);

  logic [31:0] mem[255:0];

  //initial 
    //$writememb("C:/altera/13.0sp1/lab3_computer_architecture/memory/datamem.data",mem);
  
  always_ff @(addr_i or rst_ni)
    if (rst_ni)
      r_data_o = mem[addr_i];
    else
      r_data_o = 32'd0;

  always_ff @(posedge clk_i /*or negedge rst_ni*/)
    begin
      //if(!rst_ni) 
          //mem[addr_i] = 32'b0; 
      if (wren_i)
          mem[addr_i] = wdata_i;
    end
   
endmodule : data_mem