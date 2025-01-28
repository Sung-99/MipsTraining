module InstructionMemory (
    input wire clk,               
    input wire MemRead,           
    input wire MemWrite,           
    input wire [4:0] address,      
    input wire [31:0] write_data,   
    output reg [31:0] read_data     
);

    
    reg [7:0] memory [0:31]; 

   
    initial begin
        memory[0] = 8'b00000001; 
        memory[1] = 8'b00000010; 
        memory[2] = 8'b00000011; 
        memory[3] = 8'b00000100; 
        
    end

    always @(posedge clk) begin
        if (MemWrite) begin
            memory[address] <= write_data; 
        end
        if (MemRead) begin
            read_data <= memory[address];   
        end
    end

endmodule