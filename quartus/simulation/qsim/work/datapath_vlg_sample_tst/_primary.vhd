library verilog;
use verilog.vl_types.all;
entity datapath_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        enable_pc       : in     vl_logic;
        load_pc         : in     vl_logic;
        r_rs1           : in     vl_logic;
        r_rs2           : in     vl_logic;
        reset           : in     vl_logic;
        w_rd            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end datapath_vlg_sample_tst;
