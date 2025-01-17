library verilog;
use verilog.vl_types.all;
entity Processor is
    port(
        SW              : in     vl_logic_vector(17 downto 0);
        HEX7            : out    vl_logic_vector(0 to 6);
        HEX6            : out    vl_logic_vector(0 to 6);
        HEX2            : out    vl_logic_vector(0 to 6);
        HEX1            : out    vl_logic_vector(0 to 6)
    );
end Processor;
