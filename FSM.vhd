library IEEE;
use IEEE.std_logic_1164.all;

entity FSM is
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
end FSM;

architecture arq_FSM of FSM is
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
		
	end process;

	process (EA)
	begin
		case EA is
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