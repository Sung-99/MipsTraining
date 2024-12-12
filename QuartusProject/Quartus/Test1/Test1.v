module Test1 (
    input [8:0] SW,
    output [6:0] HEX0
);
	 wire [8:0] entradaBin;  // 4-bit input for the decoder
	 // Assign the lower 4 bits of SW to entradaBin
    
    // Instantiate the Decod module
    SubModule Decod_Insta(
        .entradaBin(entradaBin), // Named mapping for clarity
        .outputSegmentos(HEX0)    // Connect output to HEX0
    );
assign entradaBin = SW[3:0]; // Use the lower 4 bits of SW
endmodule

module SubModule (
    input [8:0] entradaBin,
    output reg [6:0] outputSegmentos
);
	
always @* begin
        case (entradaBin)
            4'b0000: outputSegmentos = 7'b0111111; // Display 0
            4'b0001: outputSegmentos = 7'b0000110; // Display 1
            4'b0010: outputSegmentos = 7'b1011011; // Display 2
            4'b0011: outputSegmentos = 7'b1001111; // Display 3
            4'b0100: outputSegmentos = 7'b1100110; // Display 4
            4'b0101: outputSegmentos = 7'b1101101; // Display 5
            4'b0110: outputSegmentos = 7'b1111101; // Display 6
            4'b0111: outputSegmentos = 7'b0000111; // Display 7
            4'b1000: outputSegmentos = 7'b1111111; // Display 8
            4'b1001: outputSegmentos = 7'b1101111; // Display 9
            default: outputSegmentos = 7'b0000000; // Default (off)
        endcase
    end
   
endmodule
