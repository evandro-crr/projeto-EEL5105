library IEEE;
use IEEE.std_logic_1164.all;

entity batalhaNaval is
port (	SW: in std_logic_vector (17 downto 0);
			KEY3: in std_logic;
			KEY2: in std_logic;
			KEY0: in std_logic;
			CLOCK50: in std_logic;
			
			LEDR: out std_logic_vector (7 downto 0);
			LEDG: out std_logic_vector (7 downto 0);
			HEX: out std_logic_vector (7 downto 0)
			);
end batalhaNaval;

architecture arq_batalha of batalhaNaval

signal gameend, timeend, users, fire, rstc, rstt, match: std_logic;

component TOPO_COMPARADOR
port (	user: in std_logic;
			SW: in std_logic_vector(15 downto 0);
			FIRE: in std_logic;
			MATCH: out std_logic
			);
end component;

component CONTADOR
port (	clock: in std_logic;
			RST: in std_logic;
			user: in std_logic;
			MATCH: in std_logic;
			
			LEDR: out std_logic_vector(7 downto 0);
			LEDG: out std_logic_vector(7 downto 0);
			GAMEEND: out std_logic
			);
end component;

component TIMER
port (	CLOCK50: in std_logic;
			SEL: in std_logic_vector (1 downto 0);
			RSTT: in std_logic;
			
			time_end: out std_logic;
			seteseg0: out std_logic_vector (6 downto 0);
			seteseg1: out std_logic_vector (6 downto 0)
			);
end component;

component FSM
port (	RST: in std_logic;
			FIREIN: in std_logic;
			INIT: in std_logic;			
			GAMEEND: in std_logic;
			time_end:in std_logic;
			CLOCK50: in std_logic;
			
			user: out std_logic;
			FIRE: out std_logic;
			RSTC: out std_logic;
			RSTT: out std_logic
			);
end component;

begin

F1: FSM port map (KEY0, KEY3, KEY2, gameend, timeend, CLOCK50, users, fire, rstc, rstt);
T1: TIMER port map (CLOCK50, SW(17 downto 16), rstt, timeend, HEX(0), HEX(1);
C1: CONTADOR port map (CLOCK50, rstc, users, match, LEDR, LEDG, gameend);
C2: TOPO_COMPARADOR port map (users, SW(15 downto 0), fire, match);

HEX(3) <= "1000111";
HEX(2) <=	"1111001" when SEL = "00" else
				"0100100" when SEL = "01" else
				"0110000" when SEL = "10" else
				"0010001";
				
HEX(5) <= "1000001";
HEX(4) <= 	"1111001" when users = '0' else
				"0100100";

HEX(7) <= 	"1000000" when SW(15 downto 14) = "00" else
				"1111001" when SW(15 downto 14) = "01" else
				"0100100"when SW(15 downto 14) = "10" else
				"0110000";
end arq_batalha;








			
			