library IEEE;
use ieee.std_logic_1164.all;

entity par_par is
	port(d: in std_logic_vector (3 downto 0);
		 led: buffer std_logic;
		 q:inout std_logic_vector (3 downto 0));
end par_par;

architecture a_par_par of par_par is
signal clk,ax,bx,cx,dx:std_logic;
--internal oscillator----------------
COMPONENT OSCH
GENERIC(
	NOM_FREQ: string := "53.20");
    PORT(
		STDBY    : IN  STD_LOGIC;
        OSC      : OUT STD_LOGIC;
        SEDSTDBY : OUT STD_LOGIC);
END COMPONENT;
--------------------------------------
begin
--internal oscillator------------------------------------
OSCInst0: OSCH
GENERIC MAP (NOM_FREQ  => "53.20")
PORT MAP (STDBY => '0', OSC => clk, SEDSTDBY => OPEN);
---------------------------------------------------------
	process(clk,d,q)
--internal oscillator------------------------------------
	VARIABLE count: INTEGER RANGE 0 TO 25_000_000;
---------------------------------------------------------
	begin
		if(clk'EVENT and clk='0') then
--internal oscillator------------------------------------
			IF(count < 25_000_000) THEN
				count := count + 1;
			ELSE
				count := 0;
				led <= NOT led;
			-- Primer flip flop
				if(d(3)='1') then
					ax<='1';
				else
					ax<='0';
				end if;
			-- Segundo flip flop
				if(d(2)='1') then
					bx<='1';
				else
					bx<='0';
				end if;
			-- Tercer flip flop
				if(d(1)='1') then
					cx<='1';
				else
					cx<='0';
				end if;	
			-- Cuarto flip flop
				if(d(0)='1') then
					dx<='1';
				else
					dx<='0';
				end if;
				
				q(3)<=ax;
				q(2)<=bx;
				q(1)<=cx;
				q(0)<=dx;
			END IF; -- Acaba oscilador
		end if;
	end process;
end a_par_par;
