library verilog;
use verilog.vl_types.all;
entity MUX is
    port(
        in0             : in     vl_logic_vector(31 downto 0);
        in1             : in     vl_logic_vector(31 downto 0);
        sel             : in     vl_logic;
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end MUX;
