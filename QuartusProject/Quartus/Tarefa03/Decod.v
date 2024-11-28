module Decod (
    input [8:0] entradaBin,
    output reg [6:0] outputSegmentos
);

always @* begin
    case (entradaBin)
	     
        8'b0000_0000: outputSegmentos = 7'b1000000; // caso Decimal 0
        8'b0000_0001: outputSegmentos = 7'b1111001; // caso Decimal 1
        8'b0000_0010: outputSegmentos = 7'b0100100; // caso Decimal 2
        8'b0000_0011: outputSegmentos = 7'b0110000; // caso Decimal 3
        8'b0000_0100: outputSegmentos = 7'b0011001; // caso Decimal 4
        8'b0000_0101: outputSegmentos = 7'b0010010; // caso Decimal 5
        8'b0000_0110: outputSegmentos = 7'b0000010; // caso Decimal 6
        8'b0000_0111: outputSegmentos = 7'b1111000; // caso Decimal 7
        8'b0000_1000: outputSegmentos = 7'b0000000; // caso Decimal 8
        8'b0000_1001: outputSegmentos = 7'b0010000; // caso Decimal 9
        default: outputSegmentos = 7'b1111111; // erro
    endcase
end
endmodule

module DecodInstancia(

input [17:0] SW,

output [17:0] LEDR
);
wire [8:0] entradaBin;


assign entradaBin = SW[8:0];

Decod decodd_inst (

    .entradaBin(entradaBin),
    .outputSegmentos(LEDR)
);

endmodule
