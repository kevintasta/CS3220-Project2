library verilog;
use verilog.vl_types.all;
entity RegFile is
    generic(
        index           : integer := 4;
        width           : integer := 32;
        regnumer        : vl_notype
    );
    port(
        src1_sel        : in     vl_logic_vector(3 downto 0);
        src2_sel        : in     vl_logic_vector(3 downto 0);
        wr_sel          : in     vl_logic_vector(3 downto 0);
        data_in         : in     vl_logic_vector;
        wr_en           : in     vl_logic;
        clk             : in     vl_logic;
        src1_out        : out    vl_logic_vector;
        src2_out        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of index : constant is 1;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of regnumer : constant is 3;
end RegFile;
