library verilog;
use verilog.vl_types.all;
entity DecodInstancia is
    port(
        SW              : in     vl_logic_vector(8 downto 0);
        LEDR            : out    vl_logic_vector(6 downto 0)
    );
end DecodInstancia;
