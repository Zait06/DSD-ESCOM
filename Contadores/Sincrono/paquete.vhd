library ieee;
use ieee.std_logic_1164.all;
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

	component ffjk
		port(clk,clr,pre,j,k:in std_logic;
		 q,qno:inout std_logic);
	end component;
end package;