--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:33:51 03/04/2020
-- Design Name:   
-- Module Name:   /home/lab661/Documents/xzabka03/Digital-Electronics-1/labs/05-binary_counter/binary_counter/cnt_tb00.vhd
-- Project Name:  binary_counter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: binary_cnt
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cnt_tb00 IS
END cnt_tb00;
 
ARCHITECTURE behavior OF cnt_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT binary_cnt
    PORT(
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         en_i : IN  std_logic;
         cnt_o : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';
   signal en_i : std_logic := '0';

 	--Outputs
   signal cnt_o : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: binary_cnt PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          en_i => en_i,
          cnt_o => cnt_o 
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
     wait for 100 ns;	

    wait for clk_i_period*10;
	srst_n_i <= '1';
      -- insert stimulus here 
		for i in 0 to 50 loop
    en_i <= '1';
    wait for clk_i_period*1;
    en_i <= '0';
    wait for clk_i_period*4;
end loop;
      wait;
   end process;

END;
