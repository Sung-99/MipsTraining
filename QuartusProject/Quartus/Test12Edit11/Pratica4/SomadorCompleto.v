module SomadorCompleto #(parameter WIDTH = 16) (
input wire [WIDTH-1:0] A, // operando A (parametrizável)
input wire [WIDTH-1:0] B, // operando B (parametrizável)
input wire SUB, // controle: 0 para soma, 1 para subtração
input wire SLT, // controle: 1 para operação SLT
output wire [WIDTH-1:0] S, // resultado (parametrizável)
output wire C_out, // carry out
output wire Overflow, // sinal de overflow
output wire SLT_out // eesultado da operação SLT
);


wire [WIDTH-1:0] B_in;      // entrada ajustada de B (complemento de dois para subtração)
wire [WIDTH:0] carry;       // carry entre os bits

// ajuste de B para soma ou subtração
assign B_in = SUB ? ~B : B; // complemento de B para subtração (se SUB = 1, usa ~B)

// geração do somador completo usando generate
genvar i; //genvar é usado para declarar uma variável somente de compilação, utilizada p/ indexar loops ou gerar condições
generate
	for (i = 0; i < WIDTH; i = i + 1) begin : adder_bits
		FullAdder1Bit adder (.A(A[i]),.B(B_in[i]),.C_in(i == 0 ? SUB : carry[i]),.S(S[i]),.C_out(carry[i+1]));
	end
endgenerate

// carry out
assign C_out = carry[WIDTH];// Carry out

// overflow detection
assign Overflow = (A[WIDTH-1] == B_in[WIDTH-1]) && (S[WIDTH-1] != A[WIDTH-1]);

// SLT (Set on Less Than)
assign SLT_out = SLT ? (Overflow ? ~S[WIDTH-1] : S[WIDTH-1]) : 1'b0;

endmodule

//A BASE É O SOMADOR COMPLETO DE 1 BIT!!!!!
module FullAdder1Bit (
input wire A, // bit do operando A
input wire B, // bit do operando B
input wire C_in, // barry in
output wire S, // resultado (soma ou diferença)
output wire C_out // carry out
);
assign S = A ^ B ^ C_in;
assign C_out = (A & B) | (C_in & (A ^ B));
endmodule