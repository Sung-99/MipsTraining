module MUX (
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire sel,
    output reg [31:0] out
);
    always @(*) begin
        case (sel)
            1'b0: out = in0;  // Select input 0
            1'b1: out = in1;  // Select input 1
            default: out = 32'b0; // Default case
        endcase
    end
endmodule