module ALUcontr (
    
    input [1:0] ALUOp,          // Function code for the operation
    input [5:0] funct7,          // Additional function code (if needed)
    output reg [2:0] ALUControl, // ALU control signal
    output reg ALUSrc            // ALUSrc signal (optional)
	
);

    always @(*) begin
        // Default values
       
      
	
        case (ALUOp)
             2'b10: begin // R-type instructions
                case (funct7)
                   6'b100000: begin ALUControl <= 3'b010; end  // ADD
                   6'b100010: begin ALUControl <= 3'b110; end // SUB
						 6'b100100: begin ALUControl = 3'b000; end// AND
                   6'b100101: begin ALUControl = 3'b011; end // OR
						 6'b101010: begin ALUControl = 3'b111; end // SLT
                   //Add more funct3 cases as needed
                    default: ALUControl = 3'bxxx; // Undefined operation
                endcase
            end
            
           2'b00: begin // I-type operations (e.g., ADDI)
						ALUControl <= 3'b010;
						
           end
           
     
        endcase
    end
endmodule