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
type STATES is (inicio, user1, user2, tend1, tend2, fire1, fire2);
signal EA, PS: STATES;

begin
	

	process (CLOCK50)
		begin
			EA <= PS;
	end process;
	
	process (CLOCK50, FIREIN, time_end,RST,GAMEEND)
	begin
		if RST = '0' then PS <= inicio;
		elsif GAMEEND = '1' then PS <= inicio;
		elsif rising_edge(CLOCK50) then
			if FIREIN = '0' then
				case EA is
					when inicio => PS <= inicio;
					when user1 => PS <= fire1;
					when user2 => PS <= fire2;
					when fire1 => PS <= fire1;
					when fire2 => PS <= fire2;
					when tend1 => PS <= tend1;
					when tend2 => PS <= tend2;
				end case;
			elsif INIT = '0' then
				case EA is
					when inicio => PS <= user1;
					when user1 => PS <= user1;
					when user2 => PS <= user2;
					when fire1 => PS <= fire1;
					when fire2 => PS <= fire2;
					when tend1 => PS <= tend1;
					when tend2 => PS <= tend2;
				end case;
			elsif time_end = '1' then
				case EA is
					when inicio => PS <= inicio;
					when user1 => PS <= tend1;
					when user2 => PS <= tend2;
					when fire1 => PS <= fire1;
					when fire2 => PS <= fire2;
					when tend1 => PS <= user2;
					when tend2 => PS <= user1;
				end case;
			end if;
		end if;
	end process;

	process (EA)
	begin
		case EA is
			when inicio => FIRE <= '0'; RSTC <= '1'; RSTT <='1';
			when user1 => user <= '0'; FIRE <= '0'; RSTC <= '0'; RSTT <='0';
			when user2 => user <= '1'; FIRE <= '0'; RSTC <= '0'; RSTT <='0';
			when fire1 => user <= '0'; FIRE <= '1'; RSTC <= '0'; RSTT <='1';
			when fire2 => user <= '1'; FIRE <= '1'; RSTC <= '0'; RSTT <='1';
			when tend1 => user <= '0'; FIRE <= '0'; RSTC <= '0'; RSTT <='1';
			when tend2 => user <= '1'; FIRE <= '0'; RSTC <= '0'; RSTT <='1';
		end case;
	end process;
		

end arq_FSM;


	
