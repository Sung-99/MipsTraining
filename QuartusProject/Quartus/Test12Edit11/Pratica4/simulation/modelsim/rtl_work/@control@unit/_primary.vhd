library verilog;
use verilog.vl_types.all;
entity ControlUnit is
    port(
        OPcode          : in     vl_logic_vector(5 downto 0);
        RegWrite        : out    vl_logic;
        MemRead         : out    vl_logic;
        MemWrite        : out    vl_logic;
        ALUSrc          : out    vl_logic;
        ALUOp           : out    vl_logic_vector(2 downto 0)
    );
end ControlUnit;
