library IEEE;
use IEEE.std_logic_1164.all;

entity FSM is
<<<<<<< HEAD
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
=======
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
>>>>>>> 1bb942f1828f4c15e80c9fe5ccc24463e353f0bf
			);
end FSM;

architecture arq_FSM of FSM is
<<<<<<< HEAD
	type STATES is (inicio, user1, user2, time_end_user1, time_end_user2, FIREout_end_user1, FIREout_end_user2, FIREout_init_user1, FIREout_init_user2);
	signal EA, PS: STATES;

begin
	
	process (CLOCK)
		begin
		
			EA <= PS;
			
	end process;
	
	process (CLOCK, FIREin, TIMEEND,RST,GAMEEND)
	begin
	
		if RST = '0' then PS <= inicio;
		elsif GAMEEND = '1' then PS <= inicio;
		elsif rising_edge(CLOCK) then
		
				case EA is
					when inicio => 				PS <= inicio;
					when user1 =>					PS <= user1;
					when user2 =>					PS <= user2;
					when FIREout_end_user1 =>	PS <= user2;
					when FIREout_end_user2 =>	PS <= user1;
					when time_end_user1 =>		PS <= user2;
					when time_end_user2 =>		PS <= user1;
					when FIREout_init_user1 =>	PS <= FIREout_end_user1;
					when FIREout_init_user2 =>	PS <= FIREout_end_user2;
				end case;
				
			if FIREin = '0' then
			
				case EA is
					when inicio =>					PS <= inicio;
					when user1 =>					PS <= FIREout_init_user1;
					when user2 =>					PS <= FIREout_init_user2;
					when FIREout_end_user1 =>	PS <= FIREout_end_user1;
					when FIREout_end_user2 =>	PS <= FIREout_end_user2;
					when time_end_user1 =>		PS <= time_end_user1;
					when time_end_user2 =>		PS <= time_end_user2;
					when FIREout_init_user1 =>	PS <= FIREout_end_user1;
					when FIREout_init_user2 =>	PS <= FIREout_end_user2;
				end case;
				
			elsif INIT = '0' then
			
				case EA is
					when inicio =>						PS <= user1;
					when user1 =>						PS <= user1;
					when user2 =>						PS <= user2;
					when FIREout_end_user1 =>		PS <= FIREout_end_user1;
					when FIREout_end_user2 =>		PS <= FIREout_end_user2;
					when time_end_user1 =>			PS <= time_end_user1;
					when time_end_user2 =>			PS <= time_end_user2;
					when FIREout_init_user1 =>		PS <= FIREout_init_user1;
					when FIREout_init_user2 =>		PS <= FIREout_init_user2;
				end case;
				
			elsif TIMEEND = '1' then
			
				case EA is
					when inicio =>					PS <= inicio;
					when user1 =>					PS <= time_end_user1;
					when user2 =>					PS <= time_end_user2;
					when FIREout_end_user1 =>	PS <= FIREout_end_user1;
					when FIREout_end_user2 =>	PS <= FIREout_end_user2;
					when time_end_user1 =>		PS <= time_end_user1;
					when time_end_user2 =>		PS <= time_end_user2;
					when FIREout_init_user1 =>	PS <= FIREout_init_user1;
					when FIREout_init_user2 =>	PS <= FIREout_init_user2;
				end case;
				
			end if;
			
		end if;
		
=======
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
>>>>>>> 1bb942f1828f4c15e80c9fe5ccc24463e353f0bf
	end process;

	process (EA)
	begin
		case EA is
<<<<<<< HEAD
			when	inicio =>	FIREout <= '0';
									RSTcont <= '1';
									RSTtimer <='1';
									ENABLEcont <= '0';
			when 	user1 => 	user <= '0';
									FIREout <= '0';
									RSTcont <= '0';
									RSTtimer <='0';
									ENABLEcont <= '0';
			when 	user2 => 	user <= '1';
									FIREout <= '0';
									RSTcont <= '0';
									RSTtimer <='0';
									ENABLEcont <= '0';
			when 	FIREout_end_user1 => user <= '0';
												FIREout <= '0';
												RSTcont <= '0';
												RSTtimer <='1';
												ENABLEcont <= '0';
			when 	FIREout_end_user2 => user <= '1';
												FIREout <= '0';
												RSTcont <= '0';
												RSTtimer <='1';
												ENABLEcont <= '0';
			when 	time_end_user1 => user <= '0';
											FIREout <= '0'; 
											RSTcont <= '0';
											RSTtimer <='1';
											ENABLEcont <= '0';
			when 	time_end_user2 => user <= '1';
											FIREout <= '0';
											RSTcont <= '0';
											RSTtimer <='1';
											ENABLEcont <= '0';
			when 	FIREout_init_user1 => 	user <= '0';
													FIREout <= '1';
													RSTcont <= '0';
													RSTtimer <='1';
													ENABLEcont <= '1';
			when 	FIREout_init_user2 =>	user <= '1';
													FIREout <= '1';
													RSTcont <= '0';
													RSTtimer <='1';
													ENABLEcont <= '1';
		end case;
		
	end process;
		

end arq_FSM;
=======
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
>>>>>>> 1bb942f1828f4c15e80c9fe5ccc24463e353f0bf
