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
	 
	 
	 
	
    memory[0]  = 32'b10001100001010000000000000000000; // lw $8, 0($1)  -> Carrega da memória no endereço contido em $1 para $8
    memory[4]  = 32'b10101100001010010000000000000000; // sw $9, 0($1)  -> Armazena $9 na memória no endereço contido em $1
    memory[8]  = 32'b00000001001010010100000000100000; // add $8, $1, $9 -> Soma o valor de $1 com $9 e armazena em $8
    memory[12] = 32'b10001100111010000000000000000000; // lw $8, 0($7)  -> Armazena $8 na memória no endereço ($1 + 4)
    memory[16]  = 32'b00000001000010010100000000100000; // sw $9, 4($1)  -> Carrega da memória no endereço ($1 + 4) para $9


	 /* memory[0] = 32'b10001100001010000000000000000000; // lw $8, 0($1)
    memory[4] = 32'b00000001000010010000000000100000; // sw $9, 0($1)
    memory[8] =  32'b00000001000010010100000000100000; // add $8, $1, $9
	 memory[12]  = 32'b00000001000001110001000000101010;//Reg 2 recebe Reg 9(que após o AND é 4) SLT Reg 7(QUE TEM 8)
	 memory[16]  =  32'b00000000010010010100000000100000; 
	 memory[20]  =  32'b00000000010010010100000000100000; */
	//memory[0]  =  32'b00100000110000110000000000000101; //Reg 3(que nao tem nada)recebe REG 6(que tem 1) + Constante 5
	//memory[4]  =  32'b00000000011001100001100000100010;//Reg 3 recebe REG 3(que agora tem 6) - REG 6(que tem 1)  
	//memory[8]  =  32'b00000000000000010100100000100000;//Reg 9 recebe Reg 1(que tem 4) + Reg 0(que tem 3)
	//memory[12]  = 32'b00000001001001110001000000101010;//Reg 2 recebe Reg 9(que após o AND é 4) SLT Reg 7(QUE TEM 8)
	//memory[12]  = 32'b00000001001000010001000000101010;//Reg 2 recebe Reg 9(que após o AND é 4) SLT Reg 1(QUE TEM 4)
	//memory[12]  = 32'b00000001001010010001000000100101;//Reg 2 recebe Reg 9(que após o AND é 4) OR Reg 9	
	//memory[16]  = 32'b00000001001010010001000000100101;//Reg 2 recebe Reg 9(que após o AND é 4) OR Reg 9
        
    end

    always @(*) begin
            read_data =memory[address];    // Read data from memory location
    end

endmodule 