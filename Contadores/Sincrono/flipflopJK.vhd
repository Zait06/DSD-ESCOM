library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity ffjk is
    port(clk,clr,pre,j,k:in std_logic;
		 q,qno:inout std_logic);
end	 ffjk;

architecture coffjk of ffjk is
begin
	process(clk,clr,pre)
	begin
		if(pre='1') then
			q<='1';
		elsif(clr='1') then
			q<='0';
		elsif(clk'event and clk='0') then
			if(j='0' and k='0') then
				q<=q;
			elsif(j='0' and k='1') then
				q<='0';
			elsif(j='1' and k='0') then
				q<='1';
			else
				q<=not q;
			end if;
		end if;
		qno<=not q;
	end process;
end coffjk;