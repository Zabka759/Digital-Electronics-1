library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debounce is
	port(	
	btn_i  	 : in 	std_logic;
	f_samp_i : in	std_logic;
	srst_n_i : in   std_logic;
	clk_i	 : in	std_logic;
	deb_o 	 : out	std_logic);
end Debounce;

architecture Behavioral of Debounce is
	signal sample_buffer	: std_logic_vector(4-1 downto 0) := "1111";		-- button pressed in log. 0 
begin
	process (clk_i)
	begin
		if(rising_edge(clk_i))then
			if(srst_n_i='0') then
			sample_buffer <= "1111";													
			elsif(f_samp_i='1') then													-- active every 2 ms (change in top.vhd SAMPLEBTN)
				sample_buffer <= sample_buffer(2 downto 0) & btn_i;	-- filling register with log value of BTN1
			end if;
		end if;
	end process;
	
	deb_o <= '1' when sample_buffer="1000" else '0';			 	-- send '1' when button pressed long enough 
	
end Behavioral;
