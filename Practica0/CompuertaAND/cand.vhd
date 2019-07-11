library IEEE;
use ieee.std_logic_1164.all;

entity cand is
	port(a,b:in std_logic;
		 c:out std_logic);
	attribute pin_numbers of cand: entity is
	"a:2 b:3 c:15";
end cand;

architecture comportamiento of cand is
begin
	process(a,b)
	begin
		if(a='1' and b='1') then
			c<='1';
		else
			c<='0';
		end if;
	end process;
end comportamiento;
