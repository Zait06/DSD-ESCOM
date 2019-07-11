library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;
use paquete.all;

entity dado is
    port(cadena:in std_logic_vector(4 downto 0);
		 cadenasal:out std_logic_vector(4 downto 0);
		 clean:in std_logic;
		 salida:out std_logic_vector(4 downto 0);
		 dis:out std_logic_vector(6 downto 0);
		 conteo:inout std_logic_vector(3 downto 0);
		 led,ya:out std_logic);
end	 dado;

architecture codado of dado is
type edo is (e0,e1,e2,e3,e4);
signal senal,sosc,yey:std_logic;
signal edo_pre,edo_sig:edo;
begin

led<=senal;	-- Reloj
cadenasal<=cadena;

-- Divisor para reloj
ca01:div00 port map (
			clkdiv=>sosc,
			outdiv=>senal);

-- Oscilador de la tarjeta
ca02:osc00 port map (osc_int=>sosc);

-- Avance de estados
avance:process(senal,edo_pre,edo_sig,clean,cadena)
begin
	if(clean='1') then
		edo_pre<=e0;
	elsif(senal'event and senal='0') then
		edo_pre<=edo_sig;
	end if;
end process;

-- Maquina de estado
maquina:process(cadena,edo_pre,edo_sig,clean)
variable aux:std_logic_vector(4 downto 0);
begin
	case edo_pre is
		when e0=>
			if(cadena(4)='1') then
				edo_sig<=e1;
				aux:="10000";
				yey<='1';
			else
				edo_sig<=e0;
				aux:="00000";
				yey<='1';
			end if;
		when e1=>
			if(cadena(3)='0') then
				edo_sig<=e2;
				aux:="01000";
				yey<='1';
			else
				edo_sig<=e0;
				aux:="00000";
				yey<='1';
			end if;
		when e2=>
			if(cadena(2)='1') then
				edo_sig<=e3;
				aux:="00100";
				yey<='1';
			else
				edo_sig<=e1;
				aux:="00000";
				yey<='1';
			end if;
		when e3=>
			if(cadena(1)='0') then
				edo_sig<=e4;
				aux:="00010";
				yey<='1';
			else
				edo_sig<=e2;
				aux:="00000";
				yey<='1';
			end if;
		when e4=>
			if(cadena(0)='1') then
				aux:="00001";
				yey<='0';
				edo_sig<=e0;
			else
				aux:="00000";
				edo_sig<=e3;
				yey<='1';
			end if;		
	end case;
	salida<=aux;
end process;

-- Decodificador para display de 7 segmentos
decof00:decof port map(a=>conteo,d=>dis);
ya<='1';

conteo00:nombre port map (cuentasalida=>conteo,senal=>yey,clr=>clean);

end architecture;