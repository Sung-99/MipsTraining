module Decod (
    input [8:0] entradaBin,
    output reg [6:0] outputSegmentos

);

always @* begin
    case (entradaBin)
	     
				8'b00000000: outputSegmentos = 7'b0111111; // Display 0
            8'b00000001: outputSegmentos = 7'b0000110; // Display 1
            8'b00000010: outputSegmentos = 7'b1011011; // Display 2
            8'b00000011: outputSegmentos = 7'b1001111; // Display 3
            8'b00000100: outputSegmentos = 7'b1100110; // Display 4
            8'b00000101: outputSegmentos = 7'b1101101; // Display 5
            8'b00000110: outputSegmentos = 7'b1111101; // Display 6
            8'b00000111: outputSegmentos = 7'b0000111; // Display 7
            8'b00001000: outputSegmentos = 7'b1111111; // Display 8
            8'b00001001: outputSegmentos = 7'b1101111; // Display 9
            default: outputSegmentos = 7'b0000000; // Default case (off)
    endcase
end
endmodule

module DecodInstancia(

input [8:0] SW,
output [6:0] HEX,
output [3:0] DECIMAL
);
wire [8:0] entradaBin;


assign entradaBin = SW[8:0];
assign DECIMAL = entradaBin[3:0]; //PARA EXIBIR NA APLICAÇÃO DA ONDA

Decod decodd_inst (
    .entradaBin(entradaBin),
    .outputSegmentos(HEX)
);

endmodule