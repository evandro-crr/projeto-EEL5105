library IEEE;
use IEEE.std_logic_1164.all;

entity FSM is
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
end FSM;

architecture arq_FSM of FSM is
type STATES is (s0, s1, s2, s3, s4);
signal EA, PS: STATES;

begin

process (RST, GAMEEND)
begin
	if RST = '1' then PS <= s0; end if;
	if GAMEEND = '1' then PS <= s0; end if;
end process;

process (CLOCK50)
begin
	if rising_edge(CLOCK50) then
		case EA is
			when s0 => 	if INIT = '0' then PS <= s1; end if;
			when s1 => 	if FIREIN = '0' then PS <= s2;
							elsif time_end = '1' then PS <= s3; end if;
			when s2 => 	PS <= s3;
			when s3 => 	if FIREIN = '0' then PS <= s4;
							elsif time_end = '1' then PS <= s1; end if;
			when s4 => PS <= s1;
		end case;
	end if;
end process;

process (PS,CLOCK50)
begin
	if rising_edge(CLOCK50) then
		EA <= PS;
	end if;
end process;

process (EA,CLOCK50)
begin
	if rising_edge(CLOCK50) then
		case EA is
			when s0 => user <= '0'; FIRE <= '0'; RSTC <= '1'; RSTT <= '1';
			when s1 => user <= '0'; FIRE <= '0'; RSTC <= '0'; RSTT <= '0';
			when s2 => user <= '0'; FIRE <= '1'; RSTC <= '0'; RSTT <= '1';
			when s3 => user <= '1'; FIRE <= '0'; RSTC <= '0'; RSTT <= '0';
			when s4 => user <= '1'; FIRE <= '1'; RSTC <= '0'; RSTT <= '1';
		end case;
	end if;
end process;

end arq_FSM;


	
