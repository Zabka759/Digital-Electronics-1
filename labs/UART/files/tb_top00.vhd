LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_top00 IS
END tb_top00;
 
ARCHITECTURE behavior OF tb_top00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         SW0_CPLD 	: IN  std_logic;
         SW1_CPLD 	: IN  std_logic;
         SW7_CPLD 	: IN  std_logic;
         SW8_CPLD 	: IN  std_logic;
         SW9_CPLD 	: IN  std_logic;
         SW10_CPLD 	: IN  std_logic;
         SW11_CPLD 	: IN  std_logic;
         SW12_CPLD 	: IN  std_logic;
         SW13_CPLD 	: IN  std_logic;
         SW14_CPLD 	: IN  std_logic;
         SW15_CPLD 	: IN  std_logic;
         clk_i 		: IN  std_logic;
         BTN0 		: IN  std_logic;
         BTN1 		: IN  std_logic;
         data_o 	: OUT  std_logic;
         busy_o 	: OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal SW0_CPLD 	: std_logic := '0';
   signal SW1_CPLD 	: std_logic := '0';
   signal SW7_CPLD 	: std_logic := '0';
   signal SW8_CPLD 	: std_logic := '0';
   signal SW9_CPLD 	: std_logic := '0';
   signal SW10_CPLD 	: std_logic := '0';
   signal SW11_CPLD 	: std_logic := '0';
   signal SW12_CPLD 	: std_logic := '0';
   signal SW13_CPLD 	: std_logic := '0';
   signal SW14_CPLD 	: std_logic := '0';
   signal SW15_CPLD 	: std_logic := '0';
   signal clk_i 	: std_logic := '0';
   signal BTN0 		: std_logic := '0';
   signal BTN1 		: std_logic := '0';

 	--Outputs
   signal data_o : std_logic;
   signal busy_o : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 1 us;		-- 1 MHz clock
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          SW0_CPLD 	=> SW0_CPLD,
          SW1_CPLD 	=> SW1_CPLD,
          SW7_CPLD 	=> SW7_CPLD,
          SW8_CPLD 	=> SW8_CPLD,
          SW9_CPLD 	=> SW9_CPLD,
          SW10_CPLD 	=> SW10_CPLD,
          SW11_CPLD 	=> SW11_CPLD,
          SW12_CPLD 	=> SW12_CPLD,
          SW13_CPLD 	=> SW13_CPLD,
          SW14_CPLD 	=> SW14_CPLD,
          SW15_CPLD 	=> SW15_CPLD,
          clk_i 		=> clk_i,
          BTN0 		=> BTN0,
          BTN1 		=> BTN1,
          data_o 		=> data_o,
          busy_o 		=> busy_o
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
	SW0_CPLD 	<= '1';
        SW1_CPLD	<= '0';
        SW7_CPLD 	<= '0';
        SW8_CPLD	<= '1';	
        SW9_CPLD 	<= '0';
        SW10_CPLD 	<= '1';
        SW11_CPLD 	<= '0';
        SW12_CPLD 	<= '0';
        SW13_CPLD 	<= '0';
        SW14_CPLD 	<= '1';
        SW15_CPLD	<= '0';
        BTN0 		<= '1';
        BTN1 		<= '1';
	wait for 10 ms;		
	for I in 0 to 5 loop
		BTN1 <= '0';
		wait for 10 ms;
		BTN1 <= '1';
		wait for 20 ms;
	end loop;
      	wait;
   end process;
END;
