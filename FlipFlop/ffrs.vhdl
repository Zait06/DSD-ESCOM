library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity ffsr is
    port(
			clk,clr,pre,s,r:in std_logic;
			q,qno:inout std_logic
		);
end	 ffsr;

architecture coffsr of ffsr is
begin
	process(clk,clr,pre)
	begin
		if(pre='1') then
			q<='1';
		elsif(clr='1') then
			q<='0';
		elsif(clk'event and clk='0') then
			if(s='0' and r='0') then
				q<=q;
			elsif(s='0' and r='1') then
				q<='0';
			elsif(s='1' and r='0') then
				q<='1';
			else
				q<='0';
			end if;
		end if;
		qno<=not q;
	end process;
end coffsr;