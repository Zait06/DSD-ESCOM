library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;


entity div01 is
	port
	(
		clkdiv1:in std_logic;
		outdiv1:inout std_logic
	);
end entity;

architecture div0 of div01 is
--signal sclk:std_logic;
signal sdiv:std_logic_vector(20 downto 0);
begin
	pdiv: process(clkdiv1)
	begin
		if(clkdiv1'event and clkdiv1='0') then
					if(sdiv>"000001000000000000000") then 
						sdiv<=(others=>'0');
						outdiv1<=not(outdiv1);
					else
						sdiv<= sdiv+'1';
						outdiv1<=outdiv1;
					end if;
		end if;
	end process pdiv;
 
end architecture;