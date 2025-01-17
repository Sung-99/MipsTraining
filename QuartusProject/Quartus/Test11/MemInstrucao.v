module MemInstrucao (
    input wire clk,               
    input wire MemRead,           
    input wire MemWrite,           
    input wire [4:0] address,      
    input wire [31:0] write_data,   
    output reg [31:0] read_data     
);

    
    reg [7:0] memory [0:31]; 

   
    initial begin
         memory[0] = 32'h00430820; // ADD R1, R2, R3
        memory[1] = 32'h20410004; // ADDI R1, R2, 4
        // Zerar o restante
        memory[2] = 32'h0;
        memory[3] = 32'h0;
        
    end

    always @(posedge clk) begin
        if (MemWrite) begin
            memory[address] <= write_data[7:0]; 
				 memory[address +1] <=write_data[15:8];; 
				  memory[address +2] <= write_data[23:16]; 
				   memory[address +3] <= write_data[31:24]; 
        end
        if (MemRead) begin
            read_data <= {memory[address + 3], memory[address + 2], memory[address + 1], memory[address]};   
        end
    end

endmodule