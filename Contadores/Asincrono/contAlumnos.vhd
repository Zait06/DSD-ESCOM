library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
library machxo2;
use machxo2.all;

entity contador is
    port(clr0,pre0:in std_logic;
		 led:out std_logic;
		 dis:out std_logic_vector(6 downto 0);
		 sal1:inout std_logic_vector(3 downto 0);
		 ena:out std_logic_vector(3 downto 0);
		 q0:inout std_logic_vector(3 downto 0);
		 qno0:inout std_logic_vector(3 downto 0));
end	 contador;

architecture cocontador of contador is
component fft
	port(clk,clr,pre,t:in std_logic;
		 q:inout std_logic;
		 qno:inout std_logic);
end component;
-------------------------------------
component div00 
	port(clkdiv:in std_logic;
		 outdiv:inout std_logic);
end component;
-------------------------------------
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
	port(a:in std_logic_vector(3 downto 0);
		 d:out std_logic_vector(6 downto 0));
end component;
-------------------------------------

signal senal,sena,sosc,scompu:std_logic;
signal entra1,entra2:std_logic_vector(3 downto 0);
begin

led<=senal;	-- Reloj

-- Divisor para flip flops
ca00:div00 port map (
			clkdiv=>sosc,
			outdiv=>senal); 
-- Divisor para displays
ca01:div01 port map (
			clkdiv1=>sosc,
			outdiv1=>sena);

-- Oscilador de la tarjeta
ca02:osc00 port map (osc_int=>sosc);

-- Flip flop tipo T
-- Donde el menos significativo es ff00
-- y el mas significativo es ff03

ff00:fft port map(
			clk=>senal,
			clr=>scompu,
			pre=>'0',
			t=>'1',
			q=>q0(0),
			qno=>qno0(0));
			
ff01:fft port map(
			clk=>q0(0),
			clr=>scompu,
			pre=>'0',
			t=>'1',
			q=>q0(1),
			qno=>qno0(1));
			ff02:fft port map(
			clk=>q0(1),
			clr=>'0',
			pre=>scompu,
			t=>'1',
			q=>q0(2),
			qno=>qno0(2));
			
ff03:fft port map(
			clk=>q0(2),
			clr=>scompu,
			pre=>'0',
			t=>'1',
			q=>q0(3),
			qno=>qno0(3));
			
-- Elige que display va a elegir para mostrar
-- el conteo acendente o descendente
eleccion:process(sena)
begin
	if(sena='0') then
		entra1<=q0;
		ena<="0010";
	else
		entra1<=qno0;
		ena<="1000";
	end if;
end process;

-- Decodificador para display de 7 segmentos
dis00:decof port map(a=>entra1,d=>dis);

-- Operacion de reseteo
scompu<=(q0(0) and q0(2) and q0(3));
			
end cocontador;