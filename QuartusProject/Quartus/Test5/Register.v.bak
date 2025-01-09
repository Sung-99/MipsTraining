module Register (
	 input [17:0]SW,
	 output reg [0:6] HEX0, HEX1, HEX2
    
);
	 reg [4:0] Read1, Read2, WriteReg; // entradas de 5 bits para selecionar os registradores de leitura e escrita
     
     reg [31:0] Data1, Data2;// saídas de 32 bits para os dados lidos
	reg [31:0] WriteData;// entrada de 32 bits para o dado a ser escrito
     reg RegWrite, clock; // entrada para habilitar escrita e sinal de clock
    // BLOCO de definição de parâmetros
    parameter NUM_REGS = 32;  // Número de registradores
    parameter DATA_WIDTH = 32; // Largura de dados em bits

    // declaração do banco de registradores
    reg [DATA_WIDTH-1:0] registradores [NUM_REGS-1:0];

    
	 // BLOCO que vai inicializar os registradores com valor 0
    integer i; // variável usada no loop de inicialização
    initial begin
        for (i = 0; i < NUM_REGS; i = i + 1) begin
            registradores[i] = {DATA_WIDTH{1'b0}}; // atribui 0 a todos os registradores
        end
    end
	
	 always @(*) begin
	   WriteData = SW[4:0];
	   Read1 = SW[8:5];
		Read2 = SW[12:9];
	   clock = SW[17];
		WriteReg = SW[16:15];
	 
	 end
    
	 // BLOCO de leitura assíncrona dos registradores
    // Data1 e Data2 são atualizados sempre que os índices de leitura (Read1 e Read2) mudam
    always @(*) begin
        Data1 = registradores[Read1]; // lê o valor do registrador selecionado por Read1
        Data2 = registradores[Read2]; // lê o valor do registrador selecionado por Read2
    end

    // BLOCO de escrita sincronizada no registrador
    // a escrita no banco de registradores ocorre apenas na borda positiva do clock, e somente se o sinal RegWrite estiver ativado
    always @(posedge clock) begin
        if (WriteReg != 0) begin // para não escrever no registrador 0
            registradores[WriteReg] <= WriteData; // escreve o dado no registrador selecionado por WriteReg
        end
    end
	  always @(*) begin
        HEX0 = get_hex(registradores[WriteReg][4:0]); // EXIBE APÓS ARMAZENAR NO REGISTRADOR
        HEX1 = get_hex(Data1[4:0]);
		  HEX2 = get_hex(WriteReg[2:0]);
    end
	 function [0:6] get_hex(input [4:0] value);
        case (value)
            4'b0000: get_hex = 7'b0000001; // 0
            4'b0001: get_hex = 7'b1001111; // 1
            4'b0010: get_hex = 7'b0010010; // 2
            4'b0011: get_hex = 7'b0000110; // 3
            4'b0100: get_hex = 7'b1001100; // 4
            4'b0101: get_hex = 7'b0100100; // 5
            4'b0110: get_hex = 7'b0100000; // 6
            4'b0111: get_hex = 7'b0001111; // 7
            4'b1000: get_hex = 7'b0000000; // 8
            4'b1001: get_hex = 7'b0000100; // 9
            4'b1010: get_hex = 7'b0001000; // A
            4'b1011: get_hex = 7'b1100000; // B
            4'b1100: get_hex = 7'b0110001; // C
            4'b1101: get_hex = 7'b1000010; // D
            4'b1110: get_hex = 7'b0110000; // E
            4'b1111: get_hex = 7'b0111000; // F
            default: get_hex = 7'b0000001;  // Blank for invalid input
        endcase
    endfunction

endmodule