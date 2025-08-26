library ieee;
use ieee.std_logic_1164.all;

entity biDSR is
    port(
        CLK       : in  std_logic;
        RIGHTLEFT : in  std_logic;
        SERIAL    : in  std_logic;
        q0        : out std_logic; 
        q1        : out std_logic;
        q2        : out std_logic;
        q3        : out std_logic  
    );
end entity biDSR;

architecture structural of biDSR is
    component dff is
        port(
            clk : in  std_logic;
            rst : in  std_logic;
            d   : in  std_logic;
            q   : out std_logic
        );
    end component;
    signal q_int : std_logic_vector(3 downto 0);
    signal d_bus : std_logic_vector(3 downto 0);
begin
    d_bus(0) <= SERIAL        when RIGHTLEFT = '1' else q_int(1);
    d_bus(1) <= q_int(0)       when RIGHTLEFT = '1' else q_int(2);
    d_bus(2) <= q_int(1)       when RIGHTLEFT = '1' else q_int(3);
    d_bus(3) <= q_int(2)       when RIGHTLEFT = '1' else SERIAL;
    
    gen_ff: for i in 0 to 3 generate
        dff_inst: dff
            port map(
                clk => CLK,
                rst => '0',
                d   => d_bus(i),
                q   => q_int(i)
            );
    end generate;
    q0 <= q_int(0);
    q1 <= q_int(1);
    q2 <= q_int(2);
    q3 <= q_int(3);
    
end architecture structural;