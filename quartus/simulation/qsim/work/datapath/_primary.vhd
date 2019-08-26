library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        w_rd            : in     vl_logic;
        r_rs1           : in     vl_logic;
        r_rs2           : in     vl_logic;
        enable_pc       : in     vl_logic;
        load_pc         : in     vl_logic;
        saida_teste     : out    vl_logic_vector(31 downto 0)
    );
end datapath;
