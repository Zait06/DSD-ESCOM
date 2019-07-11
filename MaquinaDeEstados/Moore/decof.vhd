library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity decof is
	port(a:in std_logic_vector(2 downto 0);
		 d:out std_logic_vector(6 downto 0));
end decof;

architecture opera of decof is
begin
	process(a)
	begin
		case a is
			when "000" => d <="1111110";	-- 0
			when "001" => d <="0110000";	-- 1
			when "010" => d <="1101101";	-- 2
			when "011" => d <="1111001";	-- 3
			when "100" => d <="0110011";	-- 4
			when "101" => d <="1011011";   -- 5
			when "110" => d <="1011111";	-- 6
			when "111" => d <="1110000";	-- 7
			when others => d <="0000000";
		end case;
	end process;
end opera;
