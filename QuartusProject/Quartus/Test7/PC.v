module PC (
    input wire clk,              
    input wire reset,           
    input wire enable,           
    input wire [3:0] load_value, 
    output reg [3:0] pc_value    
);
	  
   
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_value <= 4'b0000; // Reseta PC para 0
        end
        else if (enable) begin
            pc_value <= load_value; // carrega o valor especifico
        end
        else begin
            pc_value <= pc_value + 1; // incrementa o valor do PC 
        end
    end

endmodule