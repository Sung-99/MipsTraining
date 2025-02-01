library verilog;
use verilog.vl_types.all;
entity registrador is
    generic(
        WIDTH           : integer := 16
    );
    port(
        Read1           : in     vl_logic_vector(4 downto 0);
        Read2           : in     vl_logic_vector(4 downto 0);
        WriteReg        : in     vl_logic_vector(4 downto 0);
        WriteData       : in     vl_logic_vector;
        RegWrite        : in     vl_logic;
        clock           : in     vl_logic;
        Data1           : out    vl_logic_vector(31 downto 0);
        Data2           : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end registrador;
