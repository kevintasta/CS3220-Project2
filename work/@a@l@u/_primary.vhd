library verilog;
use verilog.vl_types.all;
entity ALU is
    generic(
        ADD             : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi0, Hi0);
        SUB             : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi0, Hi1);
        \AND\           : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi1, Hi0);
        \OR\            : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi1, Hi1);
        \XOR\           : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi0, Hi0);
        \NAND\          : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi0, Hi1);
        \NOR\           : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi1, Hi0);
        \XNOR\          : vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi1, Hi1);
        MVHI            : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi0, Hi0);
        F               : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi0, Hi1);
        EQ              : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi1, Hi0);
        LT              : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi1, Hi1);
        LTE             : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi1, Hi0, Hi0);
        T               : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi1, Hi0, Hi1);
        NE              : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi1, Hi1, Hi0);
        GTE             : vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi1, Hi1, Hi1);
        GT              : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi0);
        BEQZ            : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi1);
        BLTZ            : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi1, Hi0);
        BLTEZ           : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi1, Hi1);
        BNEZ            : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi1, Hi0, Hi0);
        BGTEZ           : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi1, Hi0, Hi1);
        BGTZ            : vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi1, Hi1, Hi0);
        data_width      : integer := 32
    );
    port(
        in1             : in     vl_logic_vector;
        in2             : in     vl_logic_vector;
        control         : in     vl_logic_vector(4 downto 0);
        \out\           : out    vl_logic_vector;
        compare         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADD : constant is 1;
    attribute mti_svvh_generic_type of SUB : constant is 1;
    attribute mti_svvh_generic_type of \AND\ : constant is 1;
    attribute mti_svvh_generic_type of \OR\ : constant is 1;
    attribute mti_svvh_generic_type of \XOR\ : constant is 1;
    attribute mti_svvh_generic_type of \NAND\ : constant is 1;
    attribute mti_svvh_generic_type of \NOR\ : constant is 1;
    attribute mti_svvh_generic_type of \XNOR\ : constant is 1;
    attribute mti_svvh_generic_type of MVHI : constant is 1;
    attribute mti_svvh_generic_type of F : constant is 1;
    attribute mti_svvh_generic_type of EQ : constant is 1;
    attribute mti_svvh_generic_type of LT : constant is 1;
    attribute mti_svvh_generic_type of LTE : constant is 1;
    attribute mti_svvh_generic_type of T : constant is 1;
    attribute mti_svvh_generic_type of NE : constant is 1;
    attribute mti_svvh_generic_type of GTE : constant is 1;
    attribute mti_svvh_generic_type of GT : constant is 1;
    attribute mti_svvh_generic_type of BEQZ : constant is 1;
    attribute mti_svvh_generic_type of BLTZ : constant is 1;
    attribute mti_svvh_generic_type of BLTEZ : constant is 1;
    attribute mti_svvh_generic_type of BNEZ : constant is 1;
    attribute mti_svvh_generic_type of BGTEZ : constant is 1;
    attribute mti_svvh_generic_type of BGTZ : constant is 1;
    attribute mti_svvh_generic_type of data_width : constant is 1;
end ALU;
