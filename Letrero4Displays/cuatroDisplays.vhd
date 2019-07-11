library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;

entity palabra is
	port(ena:inout std_logic_vector(3 downto 0);
		 dis:out std_logic_vector(6 downto 0));
end palabra;

architecture compalabra of palabra is
component div01 
	port(clkdiv1:in std_logic;
		 outdiv1:inout std_logic);
end component;
-------------------------------------
component osc00 
	port(osc_int: out std_logic);
end component;
-------------------------------------
signal p,a,l,o,j,salida:std_logic_vector(6 downto 0);
type numeros is (e0,e1,e2,e3,e4);
signal senal,sosc:std_logic;
signal edo_pre,edo_sig:numeros;
begin

-- Letras
p<="1100111";
a<="1110111";
l<="0001110";
o<="1111110";
j<="0111100";

-- Oscilador de la tarjeta
ca02:osc00 port map (osc_int=>sosc);

-- Divisor para reloj
ca01:div01 port map (
			clkdiv1=>sosc,
			outdiv1=>senal);
			
-- Avance de estados
avance:process(senal,edo_pre,edo_sig)
begin
-- Espera un evento de reloj, y cuando sea un flanco de bajada
-- este se muevo al siguiente estado, el estado presente será 
-- igual al estado siguiente que está asignado.
	if(senal'event and senal='0') then
		edo_pre<=edo_sig;
	end if;
end process;


-- ena<="0100";
-- Maquina de estado
maquina:process(edo_pre,edo_sig,ena)
-- La variable 'ena' representa los displays multiplexados
-- por cada estado que recorre, encenderá uno y cambiará al
-- siguiente estado y a su vez cambiará el display seleccionado
begin
	case edo_pre is
		when e0=>
			ena<="1000";
			salida<=p;
			edo_sig<=e1;
		when e1=>
			ena<="0100";
			salida<=a;
			edo_sig<=e2;
		when e2=>
			ena<="0010";
			salida<=l;
			edo_sig<=e3;
		when e3=>
			ena<="0001";
			salida<=o;
			edo_sig<=e0;
		when others=>salida<=j;
	end case;
end process;

dis<=salida;

end compalabra;