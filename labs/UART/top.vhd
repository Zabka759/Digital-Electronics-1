library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port (SW0_CPLD:   in  std_logic;        -- 1 or 2 stop bits
          SW1_CPLD:   in  std_logic;	     -- 0 odd  parity /1 even parity
          SW7_CPLD:   in  std_logic;	     -- bound rate 9600/19200
          
			 SW8_CPLD:   in  std_logic;        -- LSB; data bits
          SW9_CPLD:   in  std_logic;
          SW10_CPLD:  in  std_logic;
          SW11_CPLD:  in  std_logic;
			 SW12_CPLD:  in  std_logic;
          SW13_CPLD:  in  std_logic;
          SW14_CPLD:  in  std_logic;
	       SW15_CPLD:  in  std_logic;			-- MSB
         
  			 clk_i:      in  std_logic;			-- clock 1 MHz
			 BTN0:	    in  std_logic;         -- synchronous reset
			 BTN1:		 in  std_logic;			-- message send button
	 
			 data_o:		 out std_logic;			-- data output
			 busy_o: 	 out std_logic				-- indication of FSM working
	 );
end top;

architecture Behavioral of top is
	signal sample_ce_i: std_logic;
	signal Bd9600_ce 	: std_logic;
	signal Bd19200_ce : std_logic;
	signal s_data_i 	: std_logic_vector(8-1 downto 0);
	signal s_deb		: std_logic;				-- signal from debouncer
	signal s_bd_ce_i  : std_logic;				-- signal carrying chosen bd rate
begin
	s_data_i(7) <= SW15_CPLD;
	s_data_i(6) <= SW14_CPLD;
	s_data_i(5) <= SW13_CPLD;
	s_data_i(4) <= SW12_CPLD;
	s_data_i(3) <= SW11_CPLD;
	s_data_i(2) <= SW10_CPLD;	
	s_data_i(1) <= SW9_CPLD;
	s_data_i(0) <= SW8_CPLD; 
	s_bd_ce_i 	<= (((not SW7_CPLD) and Bd9600_ce) or (SW7_CPLD and Bd19200_ce));	--Bd rate switch logic
	
	DEBOUNCE: entity work.Debounce
		PORT MAP(
			btn_i  	=> BTN1,
			f_samp_i => sample_ce_i,
			srst_n_i => BTN0,
			clk_i		=> clk_i,
			deb_o 	=>	s_deb);
		
	SAMPLEBTN: entity work.clock_enable
		GENERIC MAP (g_NPERIOD => x"07D0")		-- sampling period 2 ms (2000 periods)
		PORT MAP( 
			clk_i 			=> clk_i,
			srst_n_i 		=> BTN0,
			clock_enable_o => sample_ce_i);
				
	BD9600: entity work.clock_enable
		GENERIC MAP (g_NPERIOD => x"0068")		-- 104,16 periods
		PORT MAP( 
			clk_i 			=> clk_i,
			srst_n_i 		=> BTN0,
			clock_enable_o => Bd9600_ce);
	
	BD19200: entity work.clock_enable
		GENERIC MAP (g_NPERIOD => x"0034")		-- 52,08 periods 
		PORT MAP( 
			clk_i 			=> clk_i,
			srst_n_i			=> BTN0,
			clock_enable_o => Bd19200_ce);
	
	TRANSMIT: entity work.TX_FSM
		PORT MAP(
			clk_i 	=> clk_i,
			srst_n_i => BTN0,
			msg_ce_i => s_deb,						 -- sending message enabled when BTN1 debounce successful 
			Bd_ce_i 	=> s_bd_ce_i,					 -- Bd rate
			parity_i => SW1_CPLD,
			stop_i 	=> SW0_CPLD,
			data_i 	=> s_data_i,
			data_o 	=> data_o,
			busy_o 	=> busy_o);
			
end Behavioral;

