module Processor (

	 input wire clk,
    input wire reset,
    input wire enable,
    input wire [3:0] load_value,
    input wire MemWrite,           
    input wire MemRead,           
    input wire [31:0] write_data,  
    output wire [31:0] instruction   
);


 wire [3:0] pc_value; // Current PC value
 
 
    PC pc_inst (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .load_value(load_value),
        .pc_value(pc_value)
    );

    
    MemInstrucao im_inst (
        .clk(clk),           
        .MemRead(MemRead),   
        .MemWrite(MemWrite), 
        .address(pc_value),   
        .write_data(write_data), 
        .read_data(instruction)   
    );


endmodule
