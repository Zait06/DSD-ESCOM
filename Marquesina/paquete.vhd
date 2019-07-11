library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;

package paquete is
	component div00 
		port(clkdiv:in std_logic;
			outdiv:inout std_logic);
	end component;
	
	component osc00 
		port(osc_int: out std_logic);
	end component;
	
	component div01
		port(clkdiv1:in std_logic;
		outdiv1:inout std_logic);
	end component;
	
end package;