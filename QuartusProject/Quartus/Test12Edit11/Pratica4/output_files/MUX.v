module MUX (
    input wire [31:0] in0,   // First input
    input wire [31:0] in1,   // Second input
    input wire sel,          // Select signal
    output wire [5:0] out   // Output
);
assign out = sel ? in1 : in0; // Select between in0 and in1
endmodule