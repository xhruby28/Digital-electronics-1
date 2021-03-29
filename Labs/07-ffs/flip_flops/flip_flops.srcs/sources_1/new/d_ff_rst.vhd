----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2021 14:55:58
-- Design Name: 
-- Module Name: d_ff_rst - Behavioral
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

entity d_ff_rst is
    Port ( 
        clk   : in std_logic;
        rst   : in std_logic;
        d     : in std_logic;
        q     : out std_logic;
        q_bar : out std_logic
    );
end d_ff_rst;

architecture Behavioral of d_ff_rst is

begin
    p_d_ff_rst : process (clk, rst)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                q     <= '0';
                q_bar <= '1';
            
            else
                q     <= d;
                q_bar <= not d;
            
            end if;
        end if;
    end process p_d_ff_rst;

end Behavioral;
