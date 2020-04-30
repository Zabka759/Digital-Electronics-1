--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:12:02 04/28/2020
-- Design Name:   
-- Module Name:   E:/Projekty/UART_Transmitter/tb_debounce1.vhd
-- Project Name:  UART_Transmitter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Debounce
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
 
ENTITY tb_debounce1 IS
END tb_debounce1;
 
ARCHITECTURE behavior OF tb_debounce1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Debounce
    PORT(
         btn_i : IN  std_logic;
         f_samp_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         clk_i : IN  std_logic;
         deb_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal btn_i : std_logic := '0';
   signal f_samp_i : std_logic := '0';
   signal srst_n_i : std_logic := '1';
   signal clk_i : std_logic := '0';

 	--Outputs
   signal deb_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 1 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Debounce PORT MAP (
          btn_i => btn_i,
          f_samp_i => f_samp_i,
          srst_n_i => srst_n_i,
          clk_i => clk_i,
          deb_o => deb_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 
 
	-- Sample clock process definitions
   s_clk_i_process :process
   begin
		f_samp_i <= '1';
		wait for clk_i_period;
		f_samp_i <= '0';
		wait for (10000000 ns)-clk_i_period;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		

      -- hold reset state for 100 ns.
			btn_i <= '1';
			wait for 5 ms;
			btn_i <='0';
			wait for 10 ms;
			btn_i <= '0';
			wait for 10 ms;
			btn_i <= '1';
			wait for 10 ms;
			btn_i <= '0';
			wait for 10 ms;
			btn_i <= '1';
			wait for 10 ms;
			btn_i <= '0';
			wait for 10 ms;			
			


      -- insert stimulus here 

      wait;
   end process;

END;
