library verilog;
use verilog.vl_types.all;
entity DataMemory is
    port(
        address         : in     vl_logic_vector(31 downto 0);
        write_data      : in     vl_logic_vector(31 downto 0);
        MemRead         : in     vl_logic;
        MemWrite        : in     vl_logic;
        read_data       : out    vl_logic_vector(31 downto 0)
    );
end DataMemory;
