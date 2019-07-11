library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;

entity mario is
	port(led:out std_logic;
		 mario:out std_logic_vector(4 downto 0);
		 saltar:in std_logic);
end mario;

architecture comario of mario is
component div00 
	port(clkdiv:in std_logic;
		 outdiv:inout std_logic);
end component;
-------------------------------------
component osc00 
	port(osc_int: out std_logic);
end component;
-------------------------------------
type edos is (e0,e1,e2,e3,e4);
signal senal,sosc:std_logic;
signal salida:std_logic_vector(4 downto 0);
signal edo_pre,edo_sig:edos;
begin

led<=senal;

-- Oscilador de la tarjeta
ca02:osc00 port map (osc_int=>sosc);

-- Divisor para reloj
ca01:div00 port map (
			clkdiv=>sosc,
			outdiv=>senal);
			
-- Avance de estados
avance:process(senal,edo_pre,edo_sig)
begin
	if(senal'event and senal='1') then
		edo_pre<=edo_sig;
	end if;
end process;

-- Mario saltando
mariobros:process(edo_pre,edo_sig,saltar,saltar)
begin
	case edo_pre is
		when e0=>
			if(saltar='0') then
				salida<="10000";
				edo_sig<=e0;
			else
				salida<="01000";
				edo_sig<=e1;
			end if;
		when e1=>
			if(saltar='0') then
				salida<="01000";
				edo_sig<=e0;
			else
				salida<="00100";
				edo_sig<=e2;
			end if;
		when e2=>
			if(saltar='0') then
				salida<="00100";
				edo_sig<=e1;
			else
				salida<="00010";
				edo_sig<=e3;
			end if;
		when e3=>
			if(saltar='0') then
				salida<="00010";
				edo_sig<=e2;
			else
				salida<="00001";
				edo_sig<=e3;
			end if;
	end case;
end process;

mario<=salida;

end comario;