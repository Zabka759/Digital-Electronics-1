----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:07:48 03/31/2020 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
port (
    clk_i   	: in  std_logic;			-- Clock
    BTN0  	: in std_logic;      	-- Synchronous reset srst_n_i
    BTN1  	: in std_logic;       	-- Stopwatch enable : '1' when not pushed so push to disable stopwatch counting
    
    disp_dp_o  	: out std_logic;                       	-- Decimal point
    disp_seg_o 	: out std_logic_vector(7-1 downto 0);	--	Segments of 7seg disp
    disp_dig_o 	: out std_logic_vector(4-1 downto 0)	-- Choice of one of four 7 seg displays
);
end top;

----------------------------------------------------------------------------
---Declaration of internal signals --
-------------------------------------------------------------------------------

architecture Behavioral of top is
	 signal s_ce_100Hz_i  	: std_logic;
	 signal s_data0  	: std_logic_vector(4-1 downto 0);
	 signal s_data1  	: std_logic_vector(4-1 downto 0);
	 signal s_data2  	: std_logic_vector(4-1 downto 0);
	 signal s_data3  	: std_logic_vector(4-1 downto 0);
begin

-------------------------------------------------------------------------------
---- SUB-BLOCKS ---
-------------------------------------------------------------------------------

	STOPWATCH : entity work.stopwatch
			port map (
				clk_i 		=> clk_i,
				srst_n_i 	=> BTN0,				--synchronous reset
				ce_100Hz_i	=> s_ce_100Hz_i,
				cnt_en_i 	=> BTN1,  
				
				sec_h_o => s_data3,
				sec_l_o => s_data2,
				hth_h_o => s_data1,
				hth_l_o => s_data0
			);

	CLOCKEN : entity work.clock_enable
			generic map (
				g_NPERIOD => x"0064"       -- 10 ms 
							)
			port map (
				clk_i          => clk_i,    
				srst_n_i       => BTN0,     --synchronous reset
				clock_enable_o => s_ce_100Hz_i
		);
		
	DRIVER7SEG : entity work.driver_7seg
	port map(
				clk_i 		=> clk_i,  
				srst_n_i 	=> BTN0,
				data0_i 	=> s_data0,   
				data1_i 	=> s_data1,
				data2_i 	=> s_data2, 
				data3_i 	=> s_data3,
				dp_i 		=> "1011",   
    
				dp_o 		=> disp_dp_o,                        
				seg_o 		=> disp_seg_o,   
				dig_o 		=> disp_dig_o   
);
	
end Behavioral;

