-- Evandro Chagas Ribeiro da Rosa (15100732)
-- Lucas Calvalcante de Sousa (15100751)
-- 1208A

library IEEE;
use IEEE.std_logic_1164.all;

entity batalhaNaval is
port (	SW: 			in std_logic_vector (17 downto 0);
			KEY: 			in std_ulogic_vector (3 downto 0);
			CLOCK_50:	in std_logic;
			
			LEDR: out std_logic_vector (7 downto 0);
			LEDG: out std_logic_vector (7 downto 0);
			HEX0: out std_logic_vector (6 downto 0);
			HEX1: out std_logic_vector (6 downto 0);
			HEX2: out std_logic_vector (6 downto 0);
			HEX3: out std_logic_vector (6 downto 0);
			HEX4: out std_logic_vector (6 downto 0);
			HEX5: out std_logic_vector (6 downto 0);
			HEX6: out std_logic_vector (6 downto 0);
			HEX7: out std_logic_vector (6 downto 0)
			);
end batalhaNaval;

architecture arq_batalha of batalhaNaval is

	signal gameend, timeend, users, fire, rst_cont, rst_timer, match, enable_cont: std_logic;

	component TOPO_COMPARADOR 
	port (	user:		in std_logic;
				SW:		in std_logic_vector(15 downto 0);
				FIRE:		in std_logic;
				MATCH:	out std_logic
				);
	end component;

	component CONTADOR
	port (	RST:		in std_logic;
				user:		in std_logic;
				MATCH:	in std_logic;
				ENC:		in std_logic;
				clock:	in std_logic;
				
				LEDR:		out std_logic_vector(7 downto 0);
				LEDG:		out std_logic_vector(7 downto 0);
				GAMEEND:	out std_logic
				);
	end component;

	component TIMER
	port (	CLOCK:	in std_logic;
				SEL:		in std_logic_vector (1 downto 0);
				RST:		in std_logic;
				
				time_end:	out std_logic;
				sete_seg0:	out std_logic_vector (6 downto 0);
				sete_seg1:	out std_logic_vector (6 downto 0)
			);
	end component;

	component FSM
	port (	RST:		in std_logic;
				FIREin:	in std_logic;
				INIT:		in std_logic;			
				GAMEEND:	in std_logic;
				TIMEEND:	in std_logic;
				CLOCK:	in std_logic;
				
				user:			out std_logic;
				FIREout:		out std_logic;
				RSTcont:		out std_logic;
				RSTtimer:	out std_logic;
				ENABLEcont:	out std_logic
				);
	end component;

begin

	F: FSM port map (KEY(0), KEY(3), KEY(2), gameend, timeend, CLOCK_50, users, fire, rst_cont, rst_timer, enable_cont);
	T: TIMER port map (CLOCK_50, SW(17 downto 16), rst_timer, timeend, HEX0, HEX1);
	CONT: CONTADOR port map (rst_cont, users, match, enable_cont, CLOCK_50, LEDR( 7 downto 0), LEDG( 7 downto 0), gameend);
	COMP: TOPO_COMPARADOR port map (users, SW(15 downto 0), fire, match);
	
	
	HEX3 <= 		"1000111";		
			
	HEX2 <=		"1111001" when SW(17 downto 16) = "00" else		
					"0100100" when SW(17 downto 16) = "01" else		
					"0110000" when SW(17 downto 16) = "10" else		
					"0011001";		
							
	HEX5 <= 		"1000001";		
	HEX4 <= 		"1111001" when users = '0' else		
					"0100100";		
		
	HEX7 <= 		"1000000" when SW(15 downto 14) = "00" else		
					"1111001" when SW(15 downto 14) = "01" else		
					"0100100" when SW(15 downto 14) = "10" else		
					"0110000";		
							
	HEX6 <=		"1000000" when SW(13 downto 0) = "00000000000001" else		
					"1111001" when SW(13 downto 0) = "00000000000010" else		
					"0100100" when SW(13 downto 0) = "00000000000100" else		
					"0110000" when SW(13 downto 0) = "00000000001000" else		
					"0011001" when SW(13 downto 0) = "00000000010000" else		
					"0010010" when SW(13 downto 0) = "00000000100000" else		
					"0000010" when SW(13 downto 0) = "00000001000000" else		
					"1111000" when SW(13 downto 0) = "00000010000000" else		
					"0000000" when SW(13 downto 0) = "00000100000000" else		
					"0010000" when SW(13 downto 0) = "00001000000000" else		
					"0001000" when SW(13 downto 0) = "00010000000000" else		
					"0000011" when SW(13 downto 0) = "00100000000000" else		
					"1000110" when SW(13 downto 0) = "01000000000000" else		
					"0100001" when SW(13 downto 0) = "10000000000000" else		
					"1111111";
				
end arq_batalha;








			
			