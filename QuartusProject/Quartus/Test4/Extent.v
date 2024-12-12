module Extent (
    input wire [7:0] SW,         
    output wire [0:15] LEDR     
);


assign LEDR[0:7] = SW;


endmodule
