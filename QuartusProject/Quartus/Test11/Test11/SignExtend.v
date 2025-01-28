module SignExtend (
    input wire [15:0] in,   // 16-bit input
    output wire [31:0] out  // 32-bit output
);
assign out = { {16{in[15]}}, in }; // Extend sign
endmodule