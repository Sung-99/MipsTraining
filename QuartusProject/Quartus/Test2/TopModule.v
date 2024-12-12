module TopModule (
    input wire [9:0] SW,   //6 bits totais para dividir em 2 operandos de 3 bits ou mais(sempre dividindo para 2 operandos)
   
	 output wire [0:6] HEX0, // Output for HEX0
    output wire [0:6] HEX1, // Output for HEX1
    output wire [0:6] HEX4, // Output for HEX2	
    output wire C_out       // carry
);

    wire [4:0] A; // primeiros 3 bits 
    wire [4:0] B; //segundo(operando) 3 bits
    wire [4:0] S; //soma
    wire [4:0] carry; // Declare carry wires

    //atribuindo os operandos
    assign A = SW[4:0];  
    assign B = SW[9:5]; 
	genvar i;
	generate
    for (i = 0; i < 5; i = i + 1) begin : adders
        if (i == 0) begin
            onebitadder addInst (
                .A(A[i]),          
                .B(B[i]),          
                .C_in(1'b0),       // No Cin for the least significant bit
                .S(S[i]),          
                .C_out(carry[i])     
            );
        end else begin
            onebitadder addInst (
                .A(A[i]),          
                .B(B[i]),          
                .C_in(carry[i-1]), // pega do antigo carry
                .S(S[i]),          
                .C_out(carry[i])      //leva para o prox c out
            );
        end
    end
endgenerate
    assign C_out = carry[4];
	 
	 Display #(0) HEX000(.HEXWIDTH(HEX0),.R(A));
	 Display #(1) HEX001(.HEXWIDTH(HEX1),.R(B));
	 Display #(4) HEX004(.HEXWIDTH(HEX4),.R(S));
endmodule





module onebitadder(
    input wire A, 
    input wire B, 
    input wire C_in, 
    output wire S, 
    output wire C_out
);

    assign S = A ^ B ^ C_in;      
    assign C_out = (A & B) | (C_in & (A ^ B)); 

endmodule

module Display #(parameter WIDTH = 0)(
			output wire [0:6] HEXWIDTH, 
			input wire [4:0] R // display
			);
	 // Assign HEX0 and HEX1 based on the input operands A and B
    assign HEXWIDTH = (R == 5'b00000) ? 7'b0000001 : // Display 0
                  (R == 5'b00001) ? 7'b1001111 : // Display 1
                  (R == 5'b00010) ? 7'b0010010 : // Display 2
                  (R == 5'b00011) ? 7'b0000110 : // Display 3
                  (R == 5'b00100) ? 7'b1001100 : // Display 4
                  (R == 5'b00101) ? 7'b0100100 : // Display 5
                  (R == 5'b00110) ? 7'b0100000 : // Display 6
                  (R == 5'b00111) ? 7'b0001111 : // Display 7
                  (R == 5'b01000) ? 7'b0000000 : // Display 8
                  (R == 5'b01001) ? 7'b0000100 : // Display 9
                  (R == 5'b01010) ? 7'b0001000 : // Display A
                  (R == 5'b01011) ? 7'b1100000 : // Display B
                  (R == 5'b01100) ? 7'b0110001 : // Display C
                  (R == 5'b01101) ? 7'b1000010 : // Display D
                  (R == 5'b01110) ? 7'b0110000 : // Display E
                  (R == 5'b01111) ? 7'b0111000 : // Display F
                  7'b0000001; // Default case
	

endmodule