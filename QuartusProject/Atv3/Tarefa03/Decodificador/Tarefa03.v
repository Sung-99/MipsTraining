module Tarefa03 (
    input [31:0] entradaBin,
    output reg [6:0] outputSegmentos
);

always @* begin
    case (entradaBin)
	     
        32'b0000_0000_0000_0000_0000_0000_0000_0000: outputSegmentos = 7'b1000000; // caso Decimal 0
        32'b0000_0000_0000_0000_0000_0000_0000_0001: outputSegmentos = 7'b1111001; // caso Decimal 1
        32'b0000_0000_0000_0000_0000_0000_0000_0010: outputSegmentos = 7'b0100100; // caso Decimal 2
        32'b0000_0000_0000_0000_0000_0000_0000_0011: outputSegmentos = 7'b0110000; // caso Decimal 3
        32'b0000_0000_0000_0000_0000_0000_0000_0100: outputSegmentos = 7'b0011001; // caso Decimal 4
        32'b0000_0000_0000_0000_0000_0000_0000_0101: outputSegmentos = 7'b0010010; // caso Decimal 5
        32'b0000_0000_0000_0000_0000_0000_0000_0110: outputSegmentos = 7'b0000010; // caso Decimal 6
        32'b0000_0000_0000_0000_0000_0000_0000_0111: outputSegmentos = 7'b1111000; // caso Decimal 7
        32'b0000_0000_0000_0000_0000_0000_0000_1000: outputSegmentos = 7'b0000000; // caso Decimal 8
        32'b0000_0000_0000_0000_0000_0000_0000_1001: outputSegmentos = 7'b0010000; // caso Decimal 9
        default: outputSegmentos = 7'b1111111; // erro
    endcase
end

endmodule

