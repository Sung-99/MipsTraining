module microcpu (
    input [17:0] SW,
    output wire [0:6] HEX7, HEX6,HEX5, HEX4,HEX3, HEX2, HEX1, HEX0
);
    // Declaração de fios
    wire [31:0] PCValue;
    wire [31:0] PCNext;
    wire clk;
    wire reset;
    wire enable;
    wire [31:0] instruction_out;
	 wire MemRead;
	 wire regDst;
	 wire branch;
	 wire memtoReg;
    wire [15:0] imm;
    wire [4:0] Read1;
    wire [4:0] Read2;
    wire [4:0] WriteReg;
    wire [31:0] data1_out;
    wire [31:0] data2_out;
    wire ALUSrc;
    wire [5:0] OPcode;
	 wire [2:0] ALUOp;
	 wire [2:0] ALUControl;
    wire [31:0] ALUResult;
    wire Zero;
    wire [31:0] sign_extended;
    wire [31:0] mux_output1;
	  wire [31:0] mux_output2;
	  wire [31:0] mux_output4;
    wire [31:0] WriteData;
    wire RegWrite;
	 wire [5:0] funct7;
    // Mapeamento de entradas
    assign clk = SW[17];
    assign reset = SW[16];
    assign enable = SW[15];
    wire [31:0] constant4 = 32'd4;
	 
	 
	 //ula, mux e AND antes do somador 
	 wire [4:0] ALUResult2;
    wire [31:0] mux_output3;
	 wire [1:0] Sand;
	 wire [2:0] alucontrolSimpleALU;
	 wire [31:0] outputSHIFT;
	 wire [4:0] read_data2;
	 
	
	 
	 
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
        .load_value(mux_output3),
        .pc_value(PCValue)
    );
	 
	 
	 //Ula antes do pc
	 
	 ULA alu2 (
        .A(PCNext),
        .B(Shifted),
        .ALUResult(ALUResult2),
        .ALUControl(3'b0010)
    );
	 
	 
	  //AND QUE VAI ENTRAR NO MUX
	 ANDDd andd(
	 .A(branch),
	 .B(Zero),
	 .Y(Sand)
	 );
	 
	 
	 //Mux junto a ULA ANTES DO PC
	   MUX mux3 (
        .in0(PCNext),
        .in1(ALUResult2),
        .sel(Sand),
        .out(mux_output3)
    ); 	
	 
	 //shift 2
	 ShiftLeft2 shift(
	 .A(sign_extended),
	 .Shifted(Shifted)
	 
	 );
	 
	
	 
    // Memória de instrução
    InstructionMemory im_inst (
        .clk(clk),
        .MemRead(1'b1),
        .MemWrite(1'b0),
        .address(PCValue),
        .write_data(32'b0),
        .read_data(instruction_out)
    );
	 assign OPcode = instruction_out[31:26];
	 
	  // Controle
    Controle control_unit (
        .ALUOp(ALUOp),
        .RegWrite(RegWrite),
		  .MemWrite(MemWrite),
		  .MemRead(MemRead),
        .ALUSrc(ALUSrc),
        .OPcode(OPcode),
		  .regDst(regDst),
		  .branch(branch),
		  .memtoReg(memtoReg)
		   
    );
	 
	 
	 // MUX para entrada na ULA
    MUX mux (
        .in0(instruction_out[20:16]),
        .in1(instruction_out[15:11]),
        .sel(regDst),
        .out(mux_output1)
    ); 	
    // Banco de registradores
    registrador #(.WIDTH(32)) reg_bank (
        .Read1(instruction_out[25:21]),
        .Read2(instruction_out[20:16]),
        .WriteReg(mux_output1),
        .WriteData(mux_output4),
        .RegWrite(RegWrite),
        .clock(clk),
        .Data1(data1_out),
        .Data2(data2_out)
    );

     // Extensão de sinal
    SignExtend sign_ext (
        .in(instruction_out[15:0]),
        .out(sign_extended)
    );
	 
	 
	  MUX mux2 (
        .in0(data2_out),
        .in1(sign_extended),
        .sel(ALUSrc),
        .out(mux_output2)
    ); 	
	 
	
	 
	 ALUcontr controlALU(
	 .ALUOp(ALUOp),                  // Receive ALUOp
     .funct7(instruction_out[5:0]),              //  funct 
      .ALUControl(ALUControl)         // Output ALUControl
	 );
	 
	 
    // Unidade Lógica e Aritmética (ULA)
    ULA alu (
        .A(data1_out[5:0]),
        .B(mux_output2[5:0]),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
       
    );
	
	
	 
	
    DataMemory dataM(
	 .clk(clk),
	 .address(ALUResult),
	 .write_data(data2_out),
	 .MemRead(MemRead),
	 .MemWrite(MemWrite),
	 .read_data(read_data2)
	 
	 );

	 
	   MUX mux4 (
        .in0(ALUResult),
        .in1(read_data2),
        .sel(memtoReg),
        .out(mux_output4)
    ); 
	 
    // Mapeamento dos displays de 7 segmentos
    assign HEX7 = get_hex(PCValue[3:0]);
    assign HEX6 = get_hex(PCNext[3:0]);
	 assign HEX5 = get_hex(instruction_out[25:21]);
    assign HEX4 = get_hex(instruction_out[20:16]);
    assign HEX2 = get_hex(data1_out[4:0]);
    assign HEX1 = get_hex(mux_output2[4:0]);
	 assign HEX0 = get_hex(mux_output4[4:0]);
	 	 assign HEX3 = get_hex(read_data2);
    // Função para converter valores para display de 7 segmentos
    function [0:6] get_hex(input [5:0] value);
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