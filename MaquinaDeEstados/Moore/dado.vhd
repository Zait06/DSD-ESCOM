library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity dado is
    port(dis:out std_logic_vector(6 downto 0);
		 pu:in std_logic;
		 led,ena:out std_logic);
end	 dado;

architecture codado of dado is

component div01 
	port(clkdiv1:in std_logic;
		 outdiv1:inout std_logic);
end component;
-------------------------------------
component osc00 
	port(osc_int: out std_logic);
end component;
-------------------------------------
component decof is
	port(a:in std_logic_vector(2 downto 0);
		 d:out std_logic_vector(6 downto 0));
end component;
-------------------------------------

type numeros is (e0,e1,e2,e3,e4,e5,e6);
signal senal,sosc:std_logic;
signal entra:std_logic_vector(2 downto 0);
signal edo_pre,edo_sig:numeros;
begin

led<=senal;	-- Reloj
ena<='1';

-- Divisor para reloj
ca01:div01 port map (
			clkdiv1=>sosc,
			outdiv1=>senal);

-- Oscilador de la tarjeta
ca02:osc00 port map (osc_int=>sosc);

-- Decodificador para display de 7 segmentos
dis00:decof port map(a=>entra,d=>dis);

-- Avance de estados
avance:process(senal,edo_pre,edo_sig)
begin
	if(senal'event and senal='0') then
		edo_pre<=edo_sig;
	end if;
end process;

-- Asignacion de numero
asigna:process(edo_pre)
begin
	case edo_pre is
		when e0=>entra<="000";
		when e1=>entra<="001";
		when e2=>entra<="010";
		when e3=>entra<="011";
		when e4=>entra<="100";
		when e5=>entra<="101";
		when e6=>entra<="110";
		when others=>entra<="111";
	end case;
end process;

-- Maquina de estado
maquina:process(pu,edo_pre,edo_sig)
begin
	case edo_pre is
		when e0=>
			if(pu='1') then
				edo_sig<=e0;
			else
				edo_sig<=e1;
			end if;
		when e1=>
			if(pu='1') then
				edo_sig<=e1;
			else
				edo_sig<=e2;
			end if;
		when e2=>
			if(pu='1') then
				edo_sig<=e2;
			else
				edo_sig<=e3;
			end if;
		when e3=>
			if(pu='1') then
				edo_sig<=e3;
			else
				edo_sig<=e4;
			end if;
		when e4=>
			if(pu='1') then
				edo_sig<=e4;
			else
				edo_sig<=e5;
			end if;
		when e5=>
			if(pu='1') then
				edo_sig<=e5;
			else
				edo_sig<=e6;
			end if;
		when e6=>
			if(pu='1') then
				edo_sig<=e6;
			else
				edo_sig<=e0;
			end if;
	end case;
end process;

end architecture;