module cpu (
    input [17:0] SW,
    output wire [0:6] HEX7, HEX6, HEX2, HEX1
);
    // Declaração de fios
    wire [31:0] PCValue;
    wire [31:0] PCNext;
    wire clk;
    wire reset;
    wire enable;
    wire [31:0] instruction_out;
    wire [15:0] imm;
    wire [4:0] Read1;
    wire [4:0] Read2;
    wire [4:0] WriteReg;
    wire [31:0] data1_out;
    wire [31:0] data2_out;
    wire ALUSrc;
    wire [2:0] ALUControl;
    wire [31:0] ALUResult;
    wire Zero;
    wire [31:0] sign_extended;
    wire [31:0] mux_input2;
    wire [31:0] WriteData;
    wire RegWrite;

    // Mapeamento de entradas
    assign clk = SW[17];
    assign reset = SW[16];
    assign enable = SW[15];
    wire [31:0] constant4 = 32'd4;

    // Extensão de sinal
    SignExtend sign_ext (
        .in(instruction_out[15:0]),
        .out(sign_extended)
    );

    // Somador para o PC
    SomadorCompleto #(.WIDTH(32)) adder_inst (
        .A(PCValue),
        .B(constant4),
        .SUB(1'b0),
        .SLT(1'b0),
        .S(PCNext),
        .C_out(),
        .Overflow()
    );

    // Registrador do PC
    PC pc_inst (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .load_value(PCNext),
        .pc_value(PCValue)
    );

    // Memória de instrução
    MemInstrucao im_inst (
        .clk(clk),
        .MemRead(1'b1),
        .MemWrite(1'b0),
        .address(PCValue),
        .write_data(32'b0),
        .read_data(instruction_out)
    );

    // Banco de registradores
    registrador #(.WIDTH(32)) reg_bank (
        .Read1(instruction_out[19:15]),
        .Read2(instruction_out[24:20]),
        .WriteReg(instruction_out[11:7]),
        .WriteData(ALUResult),
        .RegWrite(RegWrite),
        .clock(clk),
        .Data1(data1_out),
        .Data2(data2_out)
    );

    // MUX para entrada na ULA
    MUX mux (
        .in0(data2_out),
        .in1(sign_extended),
        .sel(ALUSrc),
        .out(mux_input2)
    );

    // Unidade Lógica e Aritmética (ULA)
    ULA alu (
        .A(data1_out),
        .B(mux_input2),
        .ALUControl(ALUControl),
        .clock(clk),
        .Result(ALUResult),
        .Zero(Zero),
        .Overflow(),
        .SLT_out()
    );



    // Mapeamento dos displays de 7 segmentos
    assign HEX7 = get_hex(PCValue[3:0]);
    assign HEX6 = get_hex(PCNext[3:0]);
    assign HEX2 = get_hex(instruction_out[19:16]);
    assign HEX1 = get_hex(instruction_out[24:20]);

    // Função para converter valores para display de 7 segmentos
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
            default: get_hex = 7'b0000001;
        endcase
    endfunction
endmodule
