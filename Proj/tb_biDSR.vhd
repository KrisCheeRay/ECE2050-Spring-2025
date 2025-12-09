library ieee;
use ieee.std_logic_1164.all;

entity tb_biDSR is
end entity tb_biDSR;

architecture sim of tb_biDSR is
    
    constant Tclk : time := 10 ns;
    
    
    signal CLK        : std_logic := '0';
    signal RIGHTLEFT  : std_logic := '0';
    signal SERIAL     : std_logic := '0';
    signal q0, q1, q2, q3 : std_logic;
    
begin
    UUT: entity work.biDSR
        port map(
            CLK       => CLK,
            RIGHTLEFT => RIGHTLEFT,
            SERIAL    => SERIAL,
            q0        => q0,
            q1        => q1,
            q2        => q2,
            q3        => q3
        );   
    clk_gen : process
    begin
        while true loop
            CLK <= '0';
            wait for Tclk/2;
            CLK <= '1';
            wait for Tclk/2;
        end loop;
        wait;
    end process;
    stimulus : process
    begin
        
        report "Time    CLK RL SER | q3 q2 q1 q0";
        
        
        RIGHTLEFT <= '1';
        SERIAL    <= '0';
        wait for 10 ns;
        
        
        SERIAL <= '1'; wait for 10 ns;
        SERIAL <= '0'; wait for 10 ns;
        SERIAL <= '1'; wait for 10 ns;
        SERIAL <= '1'; wait for 10 ns;
        SERIAL <= '0'; wait for 10 ns;
        
        
        wait for 30 ns;
        
        
        RIGHTLEFT <= '0';
        SERIAL    <= '1'; wait for 10 ns;
        SERIAL    <= '0'; wait for 10 ns;
        SERIAL    <= '1'; wait for 10 ns;
        SERIAL    <= '0'; wait for 10 ns;
        
        wait for 30 ns;
        
        report "Simulation finished";
        wait;
    end process;
    
end architecture sim;