/* ESECIFICAÇÕES DA PRATICA 3
- a execução de uma operação deve acontecer de forma sincronizada com os demais blocos do processador, portanto a cada ciclo de clock uma operação deve ser executada
- a operação que deve ser executada com os dados de entrada (A e B) é determinada pelos sinais de controle (S) e o resultado é fornecido na saída (F)
- a ULA deve ser capaz de executar cinco operações: duas lógicas: and e or e três aritméticas: soma, subtração e comparação menor que (slt)
- a subtração pode ser implementada através de uma soma com um operando em complemento de dois
- a operação Set on Less Than (slt) é derivada da operação de subtração 
*/

module ULA #(parameter WIDTH = 16) (A, B, ALUControl, clock, Result, Zero, Overflow, SLT_out);

	input wire [WIDTH-1:0] A;          // operando A : nessa linha >> WIDTH = 16, [WIDTH-1:0] equivale a [15:0]
	input wire [WIDTH-1:0] B;          // operando B : nessa linha >> WIDTH = 16, [WIDTH-1:0] equivale a [15:0]
	input wire [2:0] ALUControl;       // controle da ULA (3 bits), no caso, S no material
	input wire clock;                  // sinal de clock
	output reg [WIDTH-1:0] Result;     // resultado da operação, no caso do exemplo, é a saída F no material
	output reg Zero;                   // sinal de Zero
	output reg Overflow;               // sinal de Overflow
	output reg SLT_out;                // resultado SLT


	// sinais auxiliares para operações
	wire [WIDTH-1:0] ArithResult;     // resultado da operação aritmética
	wire [WIDTH-1:0] AndResult;       // resultado da operação AND
	wire [WIDTH-1:0] OrResult;        // resultado da operação OR
	wire CarryOut;                    // carry Out para operações aritméticas
	wire TempOverflow;                // overflow temporário
   wire TempSLT_out;                 // SLT temporário

	 
	// instância do somadorCompleto
	// A e B vem das entradas da ULA e representam os nºs que serão passados como entrada para o somadorCompleto
	// o sinal SUB diz ao somadorCompleto se ele deve fazer subtração
	SomadorCompleto #(WIDTH) arith_unit (
		.A(A), 									// operando A
      .B(B), 									// operando B
      .SUB(ALUControl == 3'b001),  		//o valor de ALUControl é comparado com 3'b001: se for igual,o usuário quer fazer uma subtração, e o SUB será ativado
      .SLT(ALUControl == 3'b100), 		//se ALUControl=3'b100, executa a operação de comparação
      .S(ArithResult), 						//S = saida do resultado aritmético
      .C_out(CarryOut), 					//carry out:é ativado quando há um "carregamento" para o próximo bit em operações de soma ou subtração
      .Overflow(TempOverflow), 			// avisa se o resultado de uma operação aritmética foi grande demais para ser representado
      .SLT_out(TempSLT_out) 				// resultado da operação SLT
);

	//implementação das operações lógicas 
	assign AndResult = A & B; //AND
	assign OrResult = A | B;  //OR

	
	//sincronização com o clock: todas as operaçõs são realizadas e o resultado é atualizado na bora de subida do clocl
	//todas as operações (e o armazenamento do resultado) irão ocorrer na borda de subida do clock		
	//as operações aritméticas estão centralizadas no somadorCompleto, enquanto as lógicas são implementadas diretamente na ULA
	//o sinal ALUControl determina qual operação será executada em cada ciclo de clock
		always @(posedge clock) begin
		case (ALUControl)// seleção do resultado com base no ALUControl
			3'b000: Result <= ArithResult;  // soma
         3'b001: Result <= ArithResult;  // subtração
         3'b010: Result <= AndResult;    // AND
         3'b011: Result <= OrResult;     // OR
         3'b100: Result <= {WIDTH{1'b0}}; // SLT (valor separado via SLT_out)
         //3'b100: Result <= {{(WIDTH-1){1'b0}}, SLT_out}; //assegura que o valor de SLT_out seja colocado no bit menos significativo, com os outros bits zerados
			default: Result <= {WIDTH{1'b0}};
		endcase
			
		// atualização de sinais adicionais
		Zero <= (Result == {WIDTH{1'b0}});  //verifica se o resultado é zero
		//se SLT_out == 0, o Result será zero, e o sinal Zero ficará alto
		Overflow <= TempOverflow;          // atualiza o sinal de overflow
		SLT_out <= TempSLT_out;            // atualiza o resultado de SLT
	end

	 
endmodule 

/*  ENTRADAS
A e B: São os dois números que a ULA vai usar para fazer o cálculo
ALUControl: Um comando que "avisa" qual operação a ULA deve executar
Por exemplo:
000 significa somar
001 significa subtrair
010 significa fazer AND (E lógico)
011 significa fazer OR (OU lógico)
100 significa fazer uma comparação SLT
*/ 


/* OPERAÇÔES
O código está dividido em partes:
1. Somar ou Subtrair: Um módulo chamado somadorCompleto cuida de somar ou subtrair os números
2. AND e OR: AND: Combina os números de forma que o resultado só será 1 se ambos forem 1
OR: Combina os números de forma que o resultado será 1 se pelo menos um for 1
*/ 


/* SLT: Se A < B, o bit de sinal do resultado da subtração será 1, indicando que SLT_out deve ser 1
Caso contrário, o bit de sinal será 0, indicando que SLT_out deve ser 0
*/