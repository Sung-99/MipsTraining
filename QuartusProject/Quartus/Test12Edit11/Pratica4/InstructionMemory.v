module InstructionMemory (
    input wire clk,                // Clock signal
    input wire MemRead,            // Control signal for reading
    input wire MemWrite,           // Control signal for writing
    input wire [31:0] address,      // Address to read/write
    input wire [31:0] write_data,   // Data to write, 8 bits
    output reg [31:0] read_data     // Read data output
);

    
    reg [31:0] memory [31:0]; 

    
    initial begin 
      memory[0]  = 32'b00100000110000110000000000000101;
	   memory[4]  = 32'b00000000011001100001100000100010;
	   memory[8]  = 32'b00100000010000010000000000000110;
		memory[12]  = 32'b00100000010000010000000000000011;	
		memory[16]  = 32'b00100000010000010000000000000001;
        
    end

    always @(*) begin
            read_data =memory[address];    // Read data from memory location
    end

endmodule