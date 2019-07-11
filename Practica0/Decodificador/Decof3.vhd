library IEEE;
use ieee.std_logic_1164.all;

entity decof is
	port(a:in std_logic_vector(2 downto 0);
		 d:out std_logic_vector(6 downto 0));
	attribute pin_numbers of decof: entity is
	"a(2):9 a(1):8 a(0):7"
	& " d(6):21 d(5):20 d(4):19 d(3):18"
	& " d(2):17 d(1):16 d(0):15";
end decof;

architecture opera of decof is
begin
	process(a)
	begin
		case a is
			when "000" => d <="0000001";
			when "001" => d <="1001111";
			when "010" => d <="0010010";
			when "011" => d <="0000110";
			when "100" => d <="1001100";
			when "101" => d <="0100100";
			when "110" => d <="0100000";
			when "111" => d <="0001111";
			when others => d <="1111111";
		end case;
	end process;
end opera;
