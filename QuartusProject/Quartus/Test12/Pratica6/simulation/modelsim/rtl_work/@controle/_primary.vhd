library verilog;
use verilog.vl_types.all;
entity Controle is
    port(
        OPcode          : in     vl_logic_vector(5 downto 0);
        RegWrite        : out    vl_logic;
        ALUSrc          : out    vl_logic;
        ALUOp           : out    vl_logic_vector(1 downto 0);
        regDst          : out    vl_logic;
        branch          : out    vl_logic;
        MemRead         : out    vl_logic;
        memtoReg        : out    vl_logic;
        MemWrite        : out    vl_logic
    );
end Controle;
