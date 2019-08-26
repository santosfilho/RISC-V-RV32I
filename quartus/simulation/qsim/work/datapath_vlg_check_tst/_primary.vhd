library verilog;
use verilog.vl_types.all;
entity datapath_vlg_check_tst is
    port(
        saida_teste     : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end datapath_vlg_check_tst;
