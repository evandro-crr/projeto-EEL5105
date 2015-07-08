library IEEE;	
use IEEE.std_logic_1164.all;
	
entity COMPARADOR is 
port (	SW: in std_logic_vector(13 downto 0);
			FIRE: in std_logic;
			MATCH: out std_logic;
			
			data: in std_logic_vector(13 downto 0)
			);
end entity;

architecture comp_arq of COMPARADOR is 
begin
	process(FIRE)
	begin
		if FIRE = '1' then
			if (SW(13 downto 0) and data(13 downto 0)) /= "00000000000000"	then
					MATCH <= '1';
			else  MATCH <= '0';
			end if;
		end if;
	end process;
end comp_arq;