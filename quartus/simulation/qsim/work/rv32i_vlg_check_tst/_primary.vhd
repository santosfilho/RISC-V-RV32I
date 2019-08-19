library verilog;
use verilog.vl_types.all;
entity rv32i_vlg_check_tst is
    port(
        rs1             : in     vl_logic_vector(31 downto 0);
        rs2             : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end rv32i_vlg_check_tst;
