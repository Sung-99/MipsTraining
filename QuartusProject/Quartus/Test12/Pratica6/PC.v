module PC (
    input wire clk,              
    input wire reset,         
    input wire enable,           
    input wire [31:0] load_value, 
    output reg [31:0] pc_value    
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_value <= 4'b0000; 
        end
        else if (enable) begin
            pc_value <= load_value; 
        end
        else begin
            pc_value <= pc_value + 4; 
        end
    end

endmodule