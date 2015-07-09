-- Evandro Chagas Ribeiro da Rosa (15100732)
-- Lucas Calvalcante de Sousa (15100751)
-- 1208A

library IEEE;
use IEEE.std_logic_1164.all;

entity TOPO_COMPARADOR is
port (	user:		in std_logic;
			SW:		in std_logic_vector(15 downto 0);
			FIRE:		in std_logic;
			MATCH:	out std_logic
			);
end TOPO_COMPARADOR;

architecture top_comp of TOPO_COMPARADOR is
	
	signal data_user1, data_user2, data_user: std_logic_vector (13 downto 0); 
		
	component ROM1
		PORT(	address :	in std_logic_vector(1 downto 0);
				data :		out std_logic_vector(13 downto 0) 
       );
	end component;
	
	component ROM2
		PORT(	address :	in std_logic_vector(1 downto 0);
				data :		out std_logic_vector(13 downto 0) 
       );
	end component;
	
	component COMPARADOR
	port (	SW:		in std_logic_vector(13 downto 0);
				FIRE:		in std_logic;
				MATCH:	out std_logic;
			
				data: in std_logic_vector(13 downto 0)
			);
	end component;
	
begin

	R1: ROM1 port map (SW(15 downto 14), data_user1);
	R2: ROM2 port map (SW(15 downto 14), data_user2);
	
	data_user <= data_user1 when user = '1' else data_user2;

	C: COMPARADOR port map (SW(13 downto 0), FIRE, MATCH, data_user);
	
end top_comp;