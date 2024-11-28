library verilog;
use verilog.vl_types.all;
entity Decod is
    port(
        SW              : in     vl_logic_vector(17 downto 0);
        LEDR            : out    vl_logic_vector(17 downto 0)
    );
end Decod;
