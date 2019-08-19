library verilog;
use verilog.vl_types.all;
entity rv32i is
    port(
        clock           : in     vl_logic;
        rd              : in     vl_logic_vector(31 downto 0);
        add_rd          : in     vl_logic_vector(4 downto 0);
        w_rd            : in     vl_logic;
        rs1             : out    vl_logic_vector(31 downto 0);
        add_rs1         : in     vl_logic_vector(4 downto 0);
        r_rs1           : in     vl_logic;
        rs2             : out    vl_logic_vector(31 downto 0);
        add_rs2         : in     vl_logic_vector(4 downto 0);
        r_rs2           : in     vl_logic
    );
end rv32i;
