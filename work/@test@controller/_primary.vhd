library verilog;
use verilog.vl_types.all;
entity TestController is
    generic(
        width           : integer := 32;
        aluop_width     : integer := 5;
        imm_width       : integer := 16
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of aluop_width : constant is 1;
    attribute mti_svvh_generic_type of imm_width : constant is 1;
end TestController;
