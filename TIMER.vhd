library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity TIMER is
port (	CLOCK50: in std_logic;
			SEL: in std_logic_vector (1 downto 0);
			RSTT: in std_logic;
			
			time_end: out std_logic
			);
end TIMER;

architecture timer_arq of TIMER is

	signal cont5: std_logic_vector (2 downto 0);
	signal cont10: std_logic_vector (3 downto 0);
	signal cont20, cont30: std_logic_vector (4 downto 0);		
	signal s5, s10, s20, s30: std_logic;
	signal clock1Hz, clock10Hz, clock01Hz: std_logic;
	
component clock_conv is
	port
	(
		IN_50MHz	: in  std_logic;
		
		-- Output ports
		OUT_0_1Hz : out std_logic;
		OUT_1Hz	: out std_logic;
		OUT_10Hz	: out std_logic
	);
end component;

begin

C1: clock_conv port map(CLOCK50,clock01Hz,clock1Hz,clock10Hz);

process (clock1Hz)
	begin
	
	if cont5 = "101" then s5 <= '1'; cont5 <= "000";
	else s5 <= '0'; cont5 <= cont5 + 1; end if;
	
	if cont10 = "1010" then s10 <= '1'; cont10 <= "0000";
	else s10 <= '0'; cont10 <= cont10 + 1; end if;
	
	if cont20 = "10100" then s20 <= '1'; cont20 <= "00000";
	else s20 <= '0'; cont20 <= cont20 + 1; end if;
	
	if cont30 = "11110" then s30 <= '1'; cont30 <= "00000";
	else s30 <= '0'; cont30 <= cont30 + 1; end if;
	
end process;

process (RSTT)
	begin 
	
	if RSTT = '1' then cont5 <= "000"; cont10 <= "0000";
							cont20 <= "00000"; cont30 <= "00000";
	end if;
	
end process;

time_end <= s5 when SEL = "11" else
				s10 when SEL = "10" else
				s20 when SEL = "01" else
				s30;
				
end timer_arq;
	
	




	