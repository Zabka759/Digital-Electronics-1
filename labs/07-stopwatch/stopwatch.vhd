----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:50:36 03/30/2020 
-- Design Name: 
-- Module Name:    stopwatch - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity stopwatch is
	port( 		--INPUTS--
		clk_i 		: in std_logic; 	--clock
		srst_n_i 	: in std_logic;  	--synchronous reset, active low
		ce_100Hz_i 	: in std_logic; 	--clock_enable
		cnt_en_i 	: in std_logic; 	--stopwatch enable by external switch
		
					--OUTPUTS--
		sec_h_o 		: out std_logic_vector (4-1 downto 0);		--tens of seconds
		sec_l_o 		: out std_logic_vector (4-1 downto 0);		--seconds
		hth_h_o 		: out std_logic_vector (4-1 downto 0);		--tenths of seconds 
		hth_l_o 		: out std_logic_vector (4-1 downto 0)		--hundreths of seconds 
			);
end stopwatch;

architecture Behavioral of stopwatch is

		signal s_hth_l : std_logic_vector(4-1 downto 0) := (others => '0');
		signal s_hth_h : std_logic_vector(4-1 downto 0) := (others => '0');
		signal s_sec_l : std_logic_vector(4-1 downto 0) := (others => '0');
		signal s_sec_h : std_logic_vector(4-1 downto 0) := (others => '0');
		
begin
		

		stopwatch_cnt : process(clk_i)
		begin
				if rising_edge(clk_i) then
					
					if srst_n_i = '0' then 				--reset (clearing bits)
						
						s_hth_l <= (others => '0');	
						s_hth_h <= (others => '0');
						s_sec_l <= (others => '0');
						s_sec_h <= (others => '0');
					
					elsif	ce_100Hz_i = '1' and cnt_en_i = '1' then	
					
							if s_sec_h = "0101" and s_sec_l = "1001" and s_hth_h = "1001" and s_hth_l = "1001" then --if 59.99 then clear all bits
									
									s_hth_l <= (others => '0');	
									s_hth_h <= (others => '0');
									s_sec_l <= (others => '0');
									s_sec_h <= (others => '0');
									
							elsif s_sec_l = "1001" and s_hth_h = "1001" and s_hth_l = "1001" then --if X9.99 then clear 9.99 and inc X
									
									s_hth_l <= (others => '0');	
									s_hth_h <= (others => '0');
									s_sec_l <= (others => '0');
									s_sec_h <= s_sec_h + 1;
									
							elsif s_hth_h = "1001" and s_hth_l = "1001" then --if YX.99 then clear .99 and increase X
									
									s_hth_l <= (others => '0');	
									s_hth_h <= (others => '0');
									s_sec_l <= s_sec_l + 1;
							
							elsif s_hth_l = "1001" then --if ZY.X9 then clear 9, inc X
									
									s_hth_l <= (others => '0');
									s_hth_h <= s_hth_h + 1;
							
							else s_hth_l <= s_hth_l + 1; --if anything else, increase hundreths of seconds
	
							end if;
						end if;
					end if;
					hth_l_o <= std_logic_vector(s_hth_l);
					hth_h_o <= std_logic_vector(s_hth_h);
					sec_l_o <= std_logic_vector(s_sec_l);
					sec_h_o <= std_logic_vector(s_sec_h);
			end process stopwatch_cnt;
end architecture Behavioral;

