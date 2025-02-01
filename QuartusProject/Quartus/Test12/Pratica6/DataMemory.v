module DataMemory (
    input wire clk,               // Sinal de clock
    input [31:0] address,         // Endereço para leitura/escrita
    input [31:0] write_data,      // Dado a ser escrito
    input MemRead,                // Controle de leitura
    input MemWrite,               // Controle de escrita
    output reg [31:0] read_data    // Dado lido da memória
);

    reg [31:0] memory [0:31];  // Memória de 32 palavras (cada uma de 32 bits)

    // 🔹 Inicializa a memória com alguns valores fixos
    initial begin
        memory[0]  = 32'h00000005;    
        memory[4]  = 32'h00000002;   
        memory[8]  = 32'h00000003;   
        memory[12] = 32'h00000007;  
        memory[16] = 32'h00000009;  
    end

    // 🔹 Leitura de dados da memória (combinacional)
    always @(*) begin
        if (MemRead) begin
            read_data = memory[address];  // Lendo a palavra no endereço correto
        end else begin
            read_data = 32'b0; // Valor padrão quando não está lendo
        end
    end

    // 🔹 Escrita de dados na memória (sincronizada com o clock)
    always @(posedge clk) begin
        if (MemWrite) begin
            memory[address[31:2]] <= write_data; // Escreve na posição correta
        end
    end

endmodule