library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TX_FSM is
    Port ( clk_i 	: in  STD_LOGIC;
           srst_n_i 	: in  STD_LOGIC;
	   msg_ce_i 	: in  STD_LOGIC;
	   Bd_ce_i 	: in  STD_LOGIC;
           parity_i 	: in  STD_LOGIC;
           stop_i 	: in  STD_LOGIC;
           data_i 	: in  STD_LOGIC_VECTOR (7 downto 0);
           data_o 	: out STD_LOGIC;		
           busy_o 	: out STD_LOGIC);
end TX_FSM;

architecture Behavioral of TX_FSM is
	TYPE state_type IS (IDLE, BD_SYNC, BIT_START, BIT_0,BIT_1,BIT_2,BIT_3,BIT_4,BIT_5,BIT_6,BIT_7,BIT_PARITY, BIT_STOP_1, BIT_STOP_2);  -- Define the states
	SIGNAL state_s : state_Type := IDLE;    		 -- Actual state signal, default IDLE
begin	
	process(clk_i)
	begin 
		if(rising_edge(clk_i)) then
			if(srst_n_i = '0') then					-- reset, set to default state
				state_s <= IDLE;
				data_o <= '1';
				busy_o <= '0';
			elsif(msg_ce_i = '1') then					
				if state_s = IDLE then
					state_s <= BD_SYNC;	-- after BTN1 enabled msg sending, wait for switched symbol rate in BD_SYNC
					data_o <= '1';
					busy_o <= '0';
				end if;
			elsif(Bd_ce_i = '1') then				
				CASE state_s is						
					when BD_SYNC => 
						state_s <= BIT_START;
						data_o <= '0';
						busy_o <= '1';
					when BIT_START => 
						state_s <= BIT_0;
						data_o <= data_i(0);
						busy_o <= '1';
					when BIT_0 => 
						state_s <= BIT_1;
						data_o <= data_i(1);
						busy_o <= '1';
					when BIT_1 => 
						state_s <= BIT_2;
						data_o <= data_i(2);
						busy_o <= '1';
					when BIT_2 => 
						state_s <= BIT_3;
						data_o <= data_i(3);
						busy_o <= '1';
					when BIT_3 => 
						state_s <= BIT_4;
						data_o <= data_i(4);
						busy_o <= '1';
					when BIT_4 => 
						state_s <= BIT_5;
						data_o <= data_i(5);
						busy_o <= '1';
					when BIT_5 => 
						state_s <= BIT_6;
						data_o <= data_i(6);
						busy_o <= '1';				
					when BIT_6 => 
						state_s <= BIT_7;
						data_o <= data_i(7);
						busy_o <= '1';
					when BIT_7 => 
						state_s <= BIT_PARITY;
						data_o <= (data_i(7) XOR data_i(6) XOR data_i(5) XOR data_i(4) XOR data_i(3) XOR data_i(2) XOR data_i(1) XOR data_i(0) XOR parity_i);	-- computing parity depending on parity_i
						busy_o <= '1';
					when BIT_PARITY => 
						state_s <= BIT_STOP_1;
						data_o <= '1';
						busy_o <= '1';
					when BIT_STOP_1 => 				
						if(stop_i = '0') then		-- SW0 in log.0; 1 stop bit 
						   state_s <= IDLE;
						   data_o <= '1';
						   busy_o <= '0';
						else 
						   state_s <= BIT_STOP_2;	-- SW0 in log.1; 2 stop bits
						   data_o <= '1';
						   busy_o <= '1';
						end if;
					when BIT_STOP_2 =>
						state_s <= IDLE;
						data_o <= '1';
						busy_o <= '0';
					when others =>
						state_s <= IDLE;
						data_o <= '1';
						busy_o <= '0';
				end case;
			end if;
		end if;
	end process;		
end Behavioral;
