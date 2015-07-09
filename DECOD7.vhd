-- Evandro Chagas Ribeiro da Rosa (15100732)
-- Lucas Calvalcante de Sousa (15100751)
-- 1208A

library IEEE;
use IEEE.std_logic_1164.all;

entity DECOD7 is 
port (	NUMERO:	in integer range 0 to 9;
			CLOCK:	in std_logic;
			
			decoded:	out std_logic_vector (6 downto 0)
		);
end DECOD7;

architecture dec7 of DECOD7 is
begin

	process (CLOCK)
		begin 
		
			case NUMERO is
				when 0 => decoded <= "1000000";
				when 1 => decoded <= "1111001";
				when 2 => decoded <= "0100100";
				when 3 => decoded <= "0110000";
				when 4 => decoded <= "0011001";
				when 5 => decoded <= "0010010";
				when 6 => decoded <= "0000010";
				when 7 => decoded <= "1111000";
				when 8 => decoded <= "0000000";
				when 9 => decoded <= "0010000";
			end case;
			
		end process;
		
end dec7;
