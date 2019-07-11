library ieee;
use ieee.std_logic_1164.all;

entity ParImpar is
	port (E: in std_logic_vector (2 downto 0);
	      D: out std_logic_vector (6 downto 0)
	      );
	attribute pin_numbers of ParImpar: entity is
	"E(0):2 E(1):3 E(2):4"
	& " d(6):21 d(5):20 d(4):19 d(3):18"
	& " d(2):17 d(1):16 d(0):15";
end entity;

architecture A_ParImpar of ParImpar is
	begin
		process (E)
			begin
				if (E(0) = '0' ) then
					D <= "0011000";
				else 
					D <= "1001111";
				end if;
		end process;
end A_ParImpar;