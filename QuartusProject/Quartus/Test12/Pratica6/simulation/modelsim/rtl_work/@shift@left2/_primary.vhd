library verilog;
use verilog.vl_types.all;
entity ShiftLeft2 is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        Shifted         : out    vl_logic_vector(31 downto 0)
    );
end ShiftLeft2;
