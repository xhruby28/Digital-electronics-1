----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 15:40:40
-- Design Name: 
-- Module Name: tb_d_latch - Behavioral
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

entity tb_d_latch is

end tb_d_latch;

architecture Behavioral of tb_d_latch is
    signal s_en     : std_logic;
    signal s_arst   : std_logic;
    signal s_d      : std_logic;
    signal s_q      : std_logic;
    signal s_q_bar  : std_logic;
begin
    uut_d_latch: entity work.d_latch
    port map(
        en      => s_en,
        arst    => s_arst,
        d       => s_d,
        q       => s_q,
        q_bar   => s_q_bar
    );
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
     p_reset_gen : process
     begin
         s_arst <= '0';
         wait for 40 ns;
         
         -- Reset activated
         s_arst <= '1';
         wait for 50 ns;
    
         --Reset deactivated
         s_arst <= '0';
         wait for 85 ns;
         
         s_arst <= '1';
         wait;
     end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_d  <= '0';
        s_en <= '0';
        
        --d sekv (en <= '0')
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 5 ns;
        
        assert ((s_arst = '0') and (s_en = '0') and (s_q = 'U') and (s_q_bar = 'U'))
        report "Test failed for reset low, en low when s_d = '0'" 
            severity error;
        
        wait for 5 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;
        s_d  <= '1';
        wait for 5 ns;
        
        assert ((s_arst = '1') and (s_en = '0') and (s_q = '0') and (s_q_bar = '1'))
        report "Test failed for reset high, en low when s_d = '1'" 
            severity error;
        
        wait for 5 ns; 
        
        s_d  <= '0';
        s_en <= '1';
        
        --d sekv (en <= '1')
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 5 ns;
        
        assert ((s_arst = '0') and (s_en = '1') and (s_q = '0') and (s_q_bar = '1'))
        report "Test failed for reset low, en high when s_d = '0'" 
            severity error;
        
        wait for 5 ns;    
        
        s_d  <= '0';
        s_en <= '0';
        
        --d sekv (en <= '0')
        wait for 10 ns;
        s_d  <= '1';
        wait for 5 ns;
        
        assert ((s_arst = '0') and (s_en = '0') and (s_q = '0') and (s_q_bar = '1'))
        report "Test failed for reset low, en low when s_d = '1'" 
            severity error;
        
        wait for 5 ns;
        s_d  <= '0';
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;
        
        s_d  <= '0';
        s_en <= '1';
        
        --d sekv (en <= '1')
        wait for 5 ns;
        
        assert ((s_arst = '0') and (s_en = '1') and (s_q = '0') and (s_q_bar = '1'))
        report "Test failed for reset low, en high when s_d = '0'" 
            severity error;
        
        wait for 5 ns;
        s_d  <= '1';
        wait for 6 ns;
        
        assert ((s_arst = '1') and (s_en = '1') and (s_q = '0') and (s_q_bar = '1'))
        report "Test failed for reset high, en high when s_d = '1'" 
            severity error;
        
        wait for 4 ns;
        s_d  <= '0';
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;
    
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end Behavioral;
