library verilog;
use verilog.vl_types.all;
entity ClockDivider is
    generic(
        counter         : integer := 25000000
    );
    port(
        clk_in          : in     vl_logic;
        clk_out         : out    vl_logic;
        locked          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of counter : constant is 1;
end ClockDivider;
