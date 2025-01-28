library verilog;
use verilog.vl_types.all;
entity SomadorCompleto is
    generic(
        WIDTH           : integer := 16
    );
    port(
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        SUB             : in     vl_logic;
        SLT             : in     vl_logic;
        S               : out    vl_logic_vector;
        C_out           : out    vl_logic;
        Overflow        : out    vl_logic;
        SLT_out         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end SomadorCompleto;
