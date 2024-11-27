library verilog;
use verilog.vl_types.all;
entity Tarefa03 is
    port(
        entradaBin      : in     vl_logic_vector(31 downto 0);
        outputSegmentos : out    vl_logic_vector(6 downto 0)
    );
end Tarefa03;
