library IEEE;
<<<<<<< HEAD
use IEEE.std_logic_1164.all;

entity TOPO_COMPARADOR is
port (	user:		in std_logic;
			SW:		in std_logic_vector(15 downto 0);
			FIRE:		in std_logic;
			MATCH:	out std_logic
=======
	use IEEE.std_logic_1164.all;

entity TOPO_COMPARADOR is
port (	user: in std_logic;
			SW: in std_logic_vector(15 downto 0);
			FIRE: in std_logic;
			MATCH: out std_logic
>>>>>>> 1bb942f1828f4c15e80c9fe5ccc24463e353f0bf
			);
end TOPO_COMPARADOR;

architecture top_comp of TOPO_COMPARADOR is
	
<<<<<<< HEAD
	signal data_user1, data_user2, data_user: std_logic_vector (13 downto 0); 
		
	component ROM1
		PORT(	address :	in std_logic_vector(1 downto 0);
				data :		out std_logic_vector(13 downto 0) 
=======
	signal data1, data2, dataU: std_logic_vector (13 downto 0); 
		
	component ROM1
		PORT(	address : in std_logic_vector(1 downto 0);
				data : out std_logic_vector(13 downto 0) 
>>>>>>> 1bb942f1828f4c15e80c9fe5ccc24463e353f0bf
       );
	end component;
	
	component ROM2
<<<<<<< HEAD
		PORT(	address :	in std_logic_vector(1 downto 0);
				data :		out std_logic_vector(13 downto 0) 
=======
		PORT(	address : in std_logic_vector(1 downto 0);
				data : out std_logic_vector(13 downto 0) 
>>>>>>> 1bb942f1828f4c15e80c9fe5ccc24463e353f0bf
       );
	end component;
	
	component COMPARADOR
<<<<<<< HEAD
	port (	SW:		in std_logic_vector(13 downto 0);
				FIRE:		in std_logic;
				MATCH:	out std_logic;
=======
	port (	SW: in std_logic_vector(13 downto 0);
				FIRE: in std_logic;
				MATCH: out std_logic;
>>>>>>> 1bb942f1828f4c15e80c9fe5ccc24463e353f0bf
			
				data: in std_logic_vector(13 downto 0)
			);
	end component;
	
begin

<<<<<<< HEAD
	R1: ROM1 port map (SW(15 downto 14), data_user1);
	R2: ROM2 port map (SW(15 downto 14), data_user2);
	
	data_user <= data_user1 when user = '1' else data_user2;

	C: COMPARADOR port map (SW(13 downto 0), FIRE, MATCH, data_user);
=======
	R1: ROM1 port map (SW(15 downto 14), data1);
	R2: ROM2 port map (SW(15 downto 14), data2);
	
	dataU <= data1 when user = '1' else data2;

	C1: COMPARADOR port map (SW(13 downto 0), FIRE, MATCH, dataU);
>>>>>>> 1bb942f1828f4c15e80c9fe5ccc24463e353f0bf
	
	
end top_comp;