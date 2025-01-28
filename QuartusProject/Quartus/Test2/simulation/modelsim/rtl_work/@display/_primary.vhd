library verilog;
use verilog.vl_types.all;
entity Display is
    generic(
        WIDTH           : integer := 0
    );
    port(
        HEXWIDTH        : out    vl_logic_vector(0 to 6);
        R               : in     vl_logic_vector(4 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end Display;
