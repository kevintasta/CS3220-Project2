library verilog;
use verilog.vl_types.all;
entity TestRegFile is
    generic(
        index           : integer := 4;
        width           : integer := 32;
        regnumer        : vl_notype
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of index : constant is 1;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of regnumer : constant is 3;
end TestRegFile;
