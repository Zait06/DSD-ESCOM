library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;

entity nombre is
	port(cuentasalida:out std_logic_vector(3 downto 0);
		 senal,clr:in std_logic);
end entity;

architecture conombre of nombre is
signal dat:std_logic_vector(3 downto 0);
begin
	process(dat,clr)
	begin
		if (clr='1') then
			dat<=(others=>'0');
		elsif (senal'event and senal='0') then
			if(dat="1111") then
				dat<=(others=>'0');
			else
				dat<=dat+'1';
			end if;
		end if;
	cuentasalida<=dat;
	end process;
end architecture;