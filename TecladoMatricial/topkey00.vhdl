library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use packagekey00.all;

entity topkey00 is
port (
	clk0: inout std_logic;
	cdiv00: in std_logic_vector (4 downto 0);
	reset0: in std_logic;
	inkey0: in std_logic_vector (3 downto 0);
	outr0: inout std_logic_vector (3 downto 0);
	outcoder0: out std_logic_vector (6 downto 0);
	outtransist0: out std_logic_vector (3 downto 0)
	
);
end topkey00;

architecture topkey0 of topkey00 is
begin
outtransist0 <= "0001";
	T00: topdiv00 port map(oscout0=> clk0,	cdiv0=>cdiv00);
	T01: contring00 port map(clks=>clk0,resets=>reset0, outs=>outr0);
	T02: coder00 port map(clkc=>clk0,incontc=>outr0, inkeyc=>inkey0,outcoderc=>outcoder0);
end topkey0;