----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2021 15:49:01
-- Design Name: 
-- Module Name: tb_t_ff_rst - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_t_ff_rst is

end tb_t_ff_rst;

architecture Behavioral of tb_t_ff_rst is
    -- Constants
    constant c_CLK_100MHZ_PERIOD : time := 10ns;
    
    -- Local signals
    signal s_clk_100MHz : std_logic; 
    signal s_rst    : std_logic;
    signal s_t      : std_logic;
    signal s_q      : std_logic;
    signal s_q_bar  : std_logic;
    
begin

    uut_t_ff_rst : entity work.t_ff_rst
        port map(
            clk   => s_clk_100MHz,
            rst => s_rst,
            t => s_t,
            q => s_q,
            q_bar => s_q_bar
        );    

    -------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 40 ms loop
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_rst<= '0';
        wait for 28 ns;
        
        -- Reset activated
        s_rst <= '1';
        wait for 13 ns;
    
        s_rst <= '0';
        wait for 17 ns;
        
        s_rst <= '1';
        wait for 33 ns;
        
        s_rst <= '1';
        
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;   
        
        s_t <= '0';
        
        wait for 42 ns;
        
        assert ((s_rst = '0') and (s_t = '0') and (s_q = '0') and (s_q_bar = '1'))
        report "'No change' failed for reset low, after clk rising when s_t = '0'" 
            severity error;
        
        wait for 3 ns;
        s_t <= '1';
        wait for 2 ns;
        
        assert ((s_rst = '0') and (s_t = '1') and (s_q = '1') and (s_q_bar = '0'))
        report "'Toggle' failed for reset low, after clk rising when s_t = '1'" 
            severity error;
        
        wait for 3 ns;
        s_t <= '0';
        wait for 2 ns;
        
        assert ((s_rst = '0') and (s_t = '0') and (s_q = '1') and (s_q_bar = '0'))
        report "'No change' failed for reset low, before clk rising when s_t = '0'" 
            severity error;
        
        wait for 3 ns;
        s_t <= '1';
        wait for 3 ns;
        
        assert ((s_rst = '0') and (s_t = '1') and (s_q = '0') and (s_q_bar = '1'))
        report "'Toggle' failed for reset low, after clk rising when s_t = '1'" 
            severity error;
        
        wait for 2 ns;
        
        wait for 40 ns;
        s_t <= '0';
        wait for 5 ns;
        s_t <= '1';
        wait for 5 ns;
        s_t <= '0';
        wait for 5 ns;
        s_t <= '1';
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
    
end Behavioral;
