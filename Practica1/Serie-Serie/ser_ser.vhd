library IEEE;
use ieee.std_logic_1164.all;

library lattice;
use lattice.components.all;
 
library machxo2;
use machxo2.all;

entity ser_par is
	port(d,clr: in std_logic;
		 led: buffer std_logic;
		 q:inout std_logic);
end ser_par;

architecture a_ser_par of ser_par is
signal ax,bx,cx,clk:std_logic;
signal opera:INTEGER RANGE 0 TO 50_000_000;
COMPONENT OSCH
GENERIC(
	NOM_FREQ: string := "53.20");
    PORT(
		STDBY    : IN  STD_LOGIC;
        OSC      : OUT STD_LOGIC;
        SEDSTDBY : OUT STD_LOGIC);
END COMPONENT;
begin
OSCInst0: OSCH
GENERIC MAP (NOM_FREQ  => "53.20")
PORT MAP (STDBY => '0', OSC => clk, SEDSTDBY => OPEN);
	reloj:PROCESS(clk)
	VARIABLE count :   INTEGER RANGE 0 TO 25_000_000;
	VARIABLE yoyo :   INTEGER RANGE 0 TO 50_000_000;
	BEGIN
		IF(clk'EVENT AND clk = '0') THEN
			IF(count < 25_000_000) THEN
				count := count + 1;
				yoyo:= yoyo + 1;
			ELSE
				count := 0;
				led <= NOT led;
				IF(yoyo<50_000_000) THEN
					yoyo:= yoyo + 1;
				ELSE
					yoyo := 0;
				END IF;
			END IF;
		END IF;
		opera<=yoyo;
	END PROCESS;
-------------------------------------------------------
	ff1:process(clk,clr)
	begin
		if(clr='1') then
			ax<='0';
		elsif(clk'EVENT and clk='0') then
			IF(opera=0) THEN
				if(d='1') then
					ax<='1';
				else
					ax<='0';
				end if;
			END IF;
		end if;
	end process;
-----------------------------------------------------------	
	ff2:process(clk,clr)
	begin
		if(clr='1') then
			bx<='0';
		elsif(clk'EVENT and clk='0') then
			IF(opera=0) THEN
				if(ax='1') then
					bx<='1';
				else
					bx<='0';
				end if;
			END IF;
		end if;
	end process;
------------------------------------------------------------
	ff3:process(clk,clr)
	begin
		if(clr='1') then
			cx<='0';
		elsif(clk'EVENT and clk='0') then
			IF(opera=0) THEN
				if(bx='1') then
					cx<='1';
				else
					cx<='0';
				end if;
			END IF;
		end if;
	end process;
------------------------------------------------------------
	ff4:process(clk,clr)
	begin
		if(clr='1') then
			q<='0';
		elsif(clk'EVENT and clk='0') then
			IF(opera=0) THEN
				if(cx='1') then
					q<='1';
				else
					q<='0';
				end if;
			END IF;
		end if;
	end process;
------------------------------------------------------------
end a_ser_par;
