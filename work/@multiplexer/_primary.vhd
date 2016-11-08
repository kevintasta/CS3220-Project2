library verilog;
use verilog.vl_types.all;
entity Multiplexer is
    generic(
        width           : integer := 32
    );
    port(
        src0            : in     vl_logic_vector;
        src1            : in     vl_logic_vector;
        src2            : in     vl_logic_vector;
        sel             : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end Multiplexer;
