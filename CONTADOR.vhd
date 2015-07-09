-- Evandro Chagas Ribeiro da Rosa (15100732)
-- Lucas Calvalcante de Sousa (15100751)
-- 1208A

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity CONTADOR is
port (	RST:		in std_logic;
			user:		in std_logic;
			MATCH:	in std_logic;
			ENC:		in std_logic;
			clock:	in std_logic;
			
			LEDR:		out std_logic_vector(7 downto 0);
			LEDG:		out std_logic_vector(7 downto 0);
			GAMEEND:	out std_logic
			);
end CONTADOR;

architecture cont of CONTADOR is

	signal cont1, cont2: integer range 0 to 8;
	
begin

	process(MATCH, RST, ENC,clock)
	begin
	
		if RST = '1' then	cont1 	<= 0;
								cont2 	<= 0;
								GAMEEND	<= '0';
		elsif ENC = '0' then
			if 	cont1 = 8 then GAMEEND <= '1';
			elsif	cont2 = 8 then GAMEEND <= '1';
			end if;
		elsif ENC = '1' and rising_edge(clock) then
			if user = '0' and MATCH = '1' then cont1 <= cont1 + 1; end if;
			if user = '1' and MATCH = '1' then cont2 <= cont2 + 1; end if;
		end if;
		
	end process;
	
	process (clock)
	begin
	
			case cont1 is
				when 0 => LEDG <= "00000000";
				when 1 => LEDG <= "00000001";
				when 2 => LEDG <= "00000011";
				when 3 => LEDG <= "00000111";
				when 4 => LEDG <= "00001111";
				when 5 => LEDG <= "00011111";
				when 6 => LEDG <= "00111111";
				when 7 => LEDG <= "01111111";
				when 8 => LEDG <= "11111111";
			end case;
			
			case cont2 is
				when 0 => LEDR <= "00000000";
				when 1 => LEDR <= "00000001";
				when 2 => LEDR <= "00000011";
				when 3 => LEDR <= "00000111";
				when 4 => LEDR <= "00001111";
				when 5 => LEDR <= "00011111";
				when 6 => LEDR <= "00111111";
				when 7 => LEDR <= "01111111";
				when 8 => LEDR <= "11111111";
			end case;
		
	end process;
		
end cont;
