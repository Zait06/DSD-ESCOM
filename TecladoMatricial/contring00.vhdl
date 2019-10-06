library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;

entity contring00 is
port(
	clks: in std_logic;
	resets: in std_logic;
	outs: out std_logic_vector(3 downto 0)
);
end contring00;

architecture contring0 of contring00 is
signal ssr: std_logic_vector(3 downto 0);
begin
	pring: process(clks)
	begin
		if(clks'event and clks='1') then
			case resets is
				when '0' =>
					outs <= "0000";
					ssr <= "0001";
				when '1' =>
					ssr(0) <= ssr(3);
					ssr(3 downto 1) <= ssr(2 downto 0);
					outs <= ssr;
				when others => null;
			end case;
		end if;
	end process pring;

end contring0;

