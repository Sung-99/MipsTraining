library verilog;
use verilog.vl_types.all;
entity Decodd is
    port(
        entradaBin      : in     vl_logic_vector(8 downto 0);
        outputSegmentos : out    vl_logic_vector(6 downto 0)
    );
end Decodd;
