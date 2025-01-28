library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        load_value      : in     vl_logic_vector(3 downto 0);
        pc_value        : out    vl_logic_vector(3 downto 0)
    );
end PC;
