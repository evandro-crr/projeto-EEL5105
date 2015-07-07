library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity TIMER is
port (	CLOCK50: in std_logic;
			SEL: in std_logic_vector (1 downto 0);
			RSTT: in std_logic;
			
			time_end: out std_logic;
			seteseg0: out std_logic_vector (6 downto 0);
			seteseg1: out std_logic_vector (6 downto 0)
			);
end TIMER;

architecture timer_arq of TIMER is

	signal cont5: integer range 0 to 5;
	signal cont10: integer range 0 to 10;
	signal cont20: integer range 0 to 20;
	signal cont30: integer range 0 to 30;		
	signal s5, s10, s20, s30: std_logic;
	signal clock1Hz, clock10Hz, clock01Hz: std_logic;
	signal set300, set301, set200, set201, set100, set101, set50, set51: std_logic_vector(6 downto 0);
	
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

component DECOD7 is
	port (	NUMERO: in integer range 0 to 9;
				CLOCK: in std_logic;
			
				decoded: out std_logic_vector (6 downto 0)
		);
end component;

begin

C1: clock_conv port map(CLOCK50,clock01Hz,clock1Hz,clock10Hz);

D1: DECOD7 port map(cont30 / 10, CLOCK50, set301);
D2: DECOD7 port map(cont30 mod 10, CLOCK50, set300);
D3: DECOD7 port map(cont20 / 10, CLOCK50, set201);
D4: DECOD7 port map(cont20 mod 10, CLOCK50, set200);
D5: DECOD7 port map(cont10 / 10, CLOCK50, set101);
D6: DECOD7 port map(cont10 mod 10, CLOCK50, set100);
set51 <= "0000000";
D7: DECOD7 port map(cont5, CLOCK50, set50);

process (clock1Hz, RSTT)
	begin
	
	if RSTT = '1' then	cont5 <= 5; cont10 <= 10;
								cont20 <= 20; cont30 <= 30;
	else
	if cont5 = 0 then s5 <= '1'; cont5 <= 5;
	else s5 <= '0'; cont5 <= cont5 - 1; end if;
	
	if cont10 = 0 then s10 <= '1'; cont10 <= 10;
	else s10 <= '0'; cont10 <= cont10 -1; end if;
	
	if cont20 = 0 then s20 <= '1'; cont20 <= 20;
	else s20 <= '0'; cont20 <= cont20 - 1; end if;
	
	if cont30 = 0 then s30 <= '1'; cont30 <= 30;
	else s30 <= '0'; cont30 <= cont30 - 1; end if;
	
	end if;
	
end process;

seteseg0 <= set50 when SEL = "11" else
				set100 when SEL = "10" else
				set200 when SEL = "01" else
				set300;
			
seteseg1 <= set51 when SEL = "11" else
				set101 when SEL = "10" else
				set201 when SEL = "01" else
				set301;
				
time_end <= s5 when SEL = "11" else
				s10 when SEL = "10" else
				s20 when SEL = "01" else
				s30;
				
end timer_arq;
	
	




	