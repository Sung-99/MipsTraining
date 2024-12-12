library verilog;
use verilog.vl_types.all;
entity Extent is
    port(
        SW              : in     vl_logic_vector(7 downto 0);
        LEDR            : out    vl_logic_vector(0 to 15)
    );
end Extent;
