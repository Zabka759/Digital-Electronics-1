----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:38:01 04/01/2020 
-- Design Name: 
-- Module Name:    traffic_lights - Behavioral 
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


entity traffic is
	port(
		  clk_i    	: in  std_logic; 
        srst_n_i  : in  std_logic;
        cnt_en_i 	: in  std_logic;        
        lights_o	: out std_logic_vector(5 downto 0)
		  );
end entity traffic;

architecture traffic of traffic is

    type state_type is (Red_Green, Red_Yellow, Red_Red_0, Green_Red, Yellow_Red, Red_Red_1);
    signal s_state : state_type;
    signal s_count : unsigned(4-1 downto 0);
    constant sec5  : unsigned(4-1 downto 0) := "1111";	--interval 5 sekund
    constant sec1  : unsigned(4-1 downto 0) := "0011";	--interval 1 sekunda
	 
begin
    
traffic : process (clk_i, srst_n_i, cnt_en_i)    
   begin
		if rising_edge(clk_i) then
            if srst_n_i = '0' then							--synchronous reset, active low
					s_state <= Red_Red_0;						--when reseted, stop traffic
               s_count <= x"0";
            elsif cnt_en_i = '1' then
                case s_state is
                    when Red_Green =>
                        if s_count < sec5 then
                            s_state <= Red_Green;
                            s_count <= s_count + 1;
                        else
                            s_state <= Red_Yellow;
                            s_count <= x"0";
                        end if;
                    when Red_Yellow =>
                        if s_count < sec1 then
                            s_state <= Red_Yellow;
                            s_count <= s_count + 1;
                        else
                            s_state <= Red_Red_0;
                            s_count <= x"0";
                        end if;    
                    when Red_Red_0 =>
                        if s_count < sec1 then
                            s_state <= Red_Red_0;
                            s_count <= s_count + 1;
                        else
                            s_state <= Green_Red;
                            s_count <= x"0";
                        end if;
                    when Green_Red =>
                        if s_count < sec5 then
                            s_state <= Green_Red;
                            s_count <= s_count + 1;
                        else
                            s_state <= Yellow_Red;
                            s_count <= x"0";
                        end if;    
                    when Yellow_Red =>
                        if s_count < sec1 then
                            s_state <= Yellow_Red;
                            s_count <= s_count + 1;
                        else
                            s_state <= Red_Red_1;
                            s_count <= x"0";
                        end if;   
                    when Red_Red_1 =>
                        if s_count < sec1 then
                            s_state <= Red_Red_1;
                            s_count <= s_count + 1;
                        else
                            s_state <= Red_Green;
                            s_count <= x"0";
                        end if;    
                    when others =>
							 s_state <= Red_Red_0;			--when others, stop traffic
                end case;
            end if;
        end if;    
end process traffic;

	traffic_to_LED : process (s_state)
    begin
    	case s_state is
			when Red_Green   	=> lights_o <= "100001";
         when Red_Yellow 	=> lights_o <= "100010";
         when Red_Red_0  	=> lights_o <= "100100";
         when Green_Red  	=> lights_o <= "001100";
         when Yellow_Red 	=> lights_o <= "010100";
         when Red_Red_1  	=> lights_o <= "100100";
         when others 		=> lights_o <= "100100"; 	
		end case;
	end process;
end traffic;