library verilog;
use verilog.vl_types.all;
entity ALUcontr is
    port(
        ALUOp           : in     vl_logic_vector(2 downto 0);
        funct7          : in     vl_logic_vector(6 downto 0);
        ALUControl      : out    vl_logic_vector(2 downto 0);
        ALUSrc          : out    vl_logic
    );
end ALUcontr;
