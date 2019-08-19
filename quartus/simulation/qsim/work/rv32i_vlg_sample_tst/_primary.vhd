library verilog;
use verilog.vl_types.all;
entity rv32i_vlg_sample_tst is
    port(
        add_rd          : in     vl_logic_vector(4 downto 0);
        add_rs1         : in     vl_logic_vector(4 downto 0);
        add_rs2         : in     vl_logic_vector(4 downto 0);
        clock           : in     vl_logic;
        r_rs1           : in     vl_logic;
        r_rs2           : in     vl_logic;
        rd              : in     vl_logic_vector(31 downto 0);
        w_rd            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end rv32i_vlg_sample_tst;
