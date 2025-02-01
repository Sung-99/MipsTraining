module ULA(A, B, ALUControl, ALUResult, Zero);
    input [31:0] A;      
    input [31:0] B;         
    input [3:0] ALUControl; 
    output reg [31:0] ALUResult;
    output Zero;             

    // Codigos ALU Control
    parameter AND = 4'b0000;
    parameter OR  = 4'b0001;
    parameter ADD = 4'b0010;
    parameter SUB = 4'b0110;
    parameter SLT = 4'b0111;
	 parameter NOR = 4'b1100;
	 
    always @(*) begin
        case (ALUControl) // Case q define qual operacao eh realizada
            ADD: ALUResult = A + B;
            SUB: ALUResult = A - B;
            AND: ALUResult = A & B;
            OR:  ALUResult = A | B;
            SLT: ALUResult = (A < B) ? 32'b1 : 32'b0;
				NOR: ALUResult = ~(A | B);
            default: ALUResult = 32'b0;
        endcase
    end

    assign Zero = (ALUResult == 32'b0);

endmodule