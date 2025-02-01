module ShiftLeft2 (
    input [31:0] A,          // 32-bit input
    output [31:0] Shifted    // 32-bit output after shifting left by 2
);

    assign Shifted = A << 2; // Shift left by 2 bits

endmodule