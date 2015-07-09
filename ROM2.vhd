-- Evandro Chagas Ribeiro da Rosa (15100732)
-- Lucas Calvalcante de Sousa (15100751)
-- 1208A

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ROM2 IS
  PORT(
         address : in std_logic_vector(1 downto 0);
         data : out std_logic_vector(13 downto 0) 
       );
END ENTITY;

ARCHITECTURE BEV OF ROM2 IS

  type mem is array ( 0 to 2**2 - 1) of std_logic_vector(13 downto 0);
  constant my_Rom : mem := (
    0  => "00100000010000",
    1  => "00100001000000",
    2  => "00100001000000",
    3  => "00010000010000"
    );

BEGIN

   process (address)
   begin
     case address is
       when "00" => data <= my_rom(0);
       when "01" => data <= my_rom(1);
       when "10" => data <= my_rom(2);
       when "11" => data <= my_rom(3);
       when others => data <= (others => '0');
     end case;
  end process;

END BEV;
