library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity ffd is
    port(
			clk,clr,pre,d:in std_logic;
			q:inout std_logic;
			qno:inout std_logic
		);
end	 ffd;

architecture coffd of ffd is
begin
	process(clk,clr,pre)
	begin
		if(pre='1') then
			q<='1';
		elsif(clr='1') then
			q<='0';
		elsif(clk'event and clk='0') then
			q<=d;
		end if;
		qno<=not q;
	end process;
end cofft;