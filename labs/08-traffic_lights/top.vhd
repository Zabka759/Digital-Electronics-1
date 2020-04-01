----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:10:38 04/01/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity top is
port(
    clk_i    	: in  std_logic;  
	 BTN0			: in  std_logic;
	 
	 LD0_CPLD   : out  std_logic;	 
 	 LD1_CPLD   : out  std_logic; 
	 LD4_CPLD   : out  std_logic; 
	 LD5_CPLD   : out  std_logic; 
	 LD8_CPLD   : out  std_logic;   
	 LD12_CPLD  : out  std_logic       	
	 );
end entity top;


architecture top of top is
    signal s_enable  : std_logic;
	 signal s_light: std_logic_vector(5 downto 0);
begin


	CLOCKEN : entity work.clock_enable
    generic map(g_NPERIOD 	 => x"0D02")
    port map(clk_i		 	 => clk_i,
				 srst_n_i	 	 => BTN0,
             clock_enable_o => s_enable);


	TRAFFICS : entity work.traffic
    port map(clk_i	 => clk_i,
				 cnt_en_i => s_enable,
				 srst_n_i => BTN0,
             lights_o  => s_light);
				 
	LD0_CPLD <= s_light(0);		--green0
	LD1_CPLD <= s_light(1);		--yellow0
	LD8_CPLD <= s_light(2);		--red0
	LD4_CPLD <= s_light(3);		--green1
	LD5_CPLD <= s_light(4);		--yellow1
	LD12_CPLD <= s_light(5);	--red1
            
end architecture top;