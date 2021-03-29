----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 15:47:39
-- Design Name: 
-- Module Name: d_ff_arst - Behavioral
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

entity d_ff_arst is
    Port ( 
        clk   : in std_logic;
        arst  : in std_logic;
        d     : in std_logic;
        q     : out std_logic;
        q_bar : out std_logic
    );
end d_ff_arst;

architecture Behavioral of d_ff_arst is

begin
    p_d_ff_arst : process (clk, arst)
    begin
        if (arst = '1') then
            q     <= '0';
            q_bar <= '1';
        
        elsif rising_edge(clk) then
            q     <= d;
            q_bar <= not d;
        
        end if;
    end process p_d_ff_arst;

end Behavioral;
