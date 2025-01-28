library verilog;
use verilog.vl_types.all;
entity TopModule is
    port(
        SW              : in     vl_logic_vector(9 downto 0);
        HEX0            : out    vl_logic_vector(0 to 6);
        HEX1            : out    vl_logic_vector(0 to 6);
        HEX4            : out    vl_logic_vector(0 to 6);
        C_out           : out    vl_logic
    );
end TopModule;
