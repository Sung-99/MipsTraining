library verilog;
use verilog.vl_types.all;
entity ULA is
    generic(
        WIDTH           : integer := 16
    );
    port(
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        ALUControl      : in     vl_logic_vector(2 downto 0);
        clock           : in     vl_logic;
        Result          : out    vl_logic_vector;
        Zero            : out    vl_logic;
        Overflow        : out    vl_logic;
        SLT_out         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end ULA;
