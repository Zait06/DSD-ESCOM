library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;

package paquete is
	component div00 
		port
		(
			clkdiv:in std_logic;
			outdiv:inout std_logic
		);
	end component;
	
	component osc00 
		port(osc_int: out std_logic);
	end component;
	
	component decof
		port(a:in std_logic_vector(3 downto 0);
			d:out std_logic_vector(6 downto 0));
	end component;
	
	
end package;