----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 16:08:08
-- Design Name: 
-- Module Name: jk_ff_rst - Behavioral
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

entity jk_ff_rst is
    Port ( 
        clk     : in std_logic;
        rst     : in std_logic;
        j       : in std_logic;
        k       : in std_logic;
        q       : out std_logic;
        q_bar   : out std_logic
    );
end jk_ff_rst;

architecture Behavioral of jk_ff_rst is
    signal s_q : std_logic;
begin

    p_jk_ff_rst : process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                s_q <= '0';
            else 
                if (j = '0' and k ='0') then
                    s_q <= s_q;
                    
                elsif (j = '0' and k ='1') then
                    s_q <= '0';
                    
                elsif (j = '1' and k ='0') then
                    s_q <= '1';
                    
                elsif (j = '1' and k ='1') then
                    s_q <= not s_q;
                    
                end if;
                
            end if;
            
        end if;
    end process p_jk_ff_rst;

    q     <= s_q;
    q_bar <= not s_q;

end Behavioral;
