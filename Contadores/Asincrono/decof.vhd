library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity decof is
	port(a:in std_logic_vector(3 downto 0);
		 d:out std_logic_vector(6 downto 0));
end decof;

architecture opera of decof is
begin
	process(a)
	begin
		case a is
			when "0000" => d <="1111110";	-- 0
			when "0001" => d <="0110000";	-- 1
			when "0010" => d <="1101101";	-- 2
			when "0011" => d <="1111001";	-- 3
			when "0100" => d <="0110011";	-- 4
			when "0101" => d <="1011011";   -- 5
			when "0110" => d <="1011111";	-- 6
			when "0111" => d <="1110000";	-- 7
			when "1000" => d <="1111111";	-- 8
			when "1001" => d <="1111011";	-- 9
			when "1010" => d <="1110111";	-- A	10
			when "1011" => d <="0011111";	-- B	11
			when "1100" => d <="1001110";	-- C	12
			when "1101" => d <="0111101";	-- D	13
			when "1110" => d <="1001111";	-- E	14
			when "1111" => d <="1000111";	-- F	15
			when others => d <="0000000";
		end case;
	end process;
end opera;
