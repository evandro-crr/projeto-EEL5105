-- Evandro Chagas Ribeiro da Rosa (15100732)
-- Lucas Calvalcante de Sousa (15100751)
-- 1208A

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity TIMER is
port (	CLOCK:	in std_logic;
			SEL:		in std_logic_vector (1 downto 0);
			RST:		in std_logic;
			
			time_end:	out std_logic;
			sete_seg0:	out std_logic_vector (6 downto 0);
			sete_seg1:	out std_logic_vector (6 downto 0)
			);
end TIMER;

architecture timer_arq of TIMER is

	signal cont5:	integer range 0 to 5;
	signal cont10: integer range 0 to 10;
	signal cont20: integer range 0 to 20;
	signal cont30: integer range 0 to 30;	
	signal clock1Hz, clock10Hz, clock01Hz: std_logic;
	signal set300, set301, set200, set201, set100, set101, set50, set51: std_logic_vector(6 downto 0);
	
component clock_conv is
	port
	(
		IN_50MHz	: in  std_logic;
		
		-- Output ports
		OUT_0_1Hz : out std_logic;
		OUT_1Hz	: 	out std_logic;
		OUT_10Hz	: 	out std_logic
	);
end component;

component DECOD7 is
	port (	NUMERO:	in integer range 0 to 9;
				CLOCK:	in std_logic;
			
				decoded:	out std_logic_vector (6 downto 0)
		);
end component;

begin

	C: clock_conv port map(CLOCK,clock01Hz,clock1Hz,clock10Hz);

	D1: DECOD7 port map(cont30 / 10, CLOCK, set301);
	D2: DECOD7 port map(cont30 mod 10, CLOCK, set300);
	D3: DECOD7 port map(cont20 / 10, CLOCK, set201);
	D4: DECOD7 port map(cont20 mod 10, CLOCK, set200);
	D5: DECOD7 port map(cont10 / 10, CLOCK, set101);
	D6: DECOD7 port map(cont10 mod 10, CLOCK, set100);
	set51 <= "1000000";
	D7: DECOD7 port map(cont5, CLOCK, set50);

	process (clock1Hz, RST)
		begin
		
		if RST = '1' then	
			cont5 <= 5;
			cont10 <= 10;
			cont20 <= 20;
			cont30 <= 30;
			time_end <= '0';
		elsif rising_edge(clock1Hz) then			
				if cont5 = 0 then 
					if SEL = "11" then 
						time_end <= '1';
					else time_end <= '0';end if;
					cont5 <= 5;
				else cont5 <= cont5 - 1; end if;
				
				if cont10 = 0 then 
					if SEL = "10" then 
						time_end <= '1';
						else time_end <= '0';	end if;
					cont10 <= 10;
				else cont10 <= cont10 - 1; end if;
				
				if cont20 = 0 then 
					if SEL = "01" then 
						time_end <= '1';
						else time_end <= '0';	end if;
					cont20 <= 20;
				else cont20 <= cont20 - 1; end if;
				
				if cont30 = 0 then 
					if SEL = "00" then 
						time_end <= '1'; 
						else time_end <= '0';	end if;
					cont30 <= 30;
				else cont30 <= cont30 - 1; end if;		
		end if;
		
	end process;

	sete_seg0 <= set50 when SEL = "11" else
					set100 when SEL = "10" else
					set200 when SEL = "01" else
					set300;
				
	sete_seg1 <= set51 when SEL = "11" else
					set101 when SEL = "10" else
					set201 when SEL = "01" else
					set301;
					
end timer_arq;
	
	




	