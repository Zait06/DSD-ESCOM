library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use paquete.all;

entity dosCont is
	port(clr0,eo:in std_logic;
		 led,ena:out std_logic;
		 dis:out std_logic_vector(6 downto 0);
		 q0:inout std_logic_vector(3 downto 0);
		 qno0:inout std_logic_vector(3 downto 0));
end entity;

architecture ComDosCont of dosCont is
signal senal,sosc:std_logic;
signal comjd,comkd,comjc,comkc,comjb,comkb,comja,comka:std_logic;
signal a,b,c,d,e,noa,nob,noc,nod,noe,aux1,aux2:std_logic;
begin
led<=senal;		-- Reloj
ena<='1';		-- Activacion del display

ca00:div00 port map (
			clkdiv=>sosc,
			outdiv=>senal);		-- Divisor de oscilador
			
ca02:osc00 port map (osc_int=>sosc);	-- Oscilador de la tarjeta

-- Compuerta de cada flip flop bit --
a<=q0(0); b<=q0(1); c<=q0(2); d<=q0(3); e<=eo;
noa<=qno0(0); nob<=qno0(1); noc<=qno0(2); nod<=qno0(3); noe<=not(eo);

	process(e)
	begin
		if(e='0') then
				comjd<=(c and nob and noa);
				comkd<= d ;
				comjc<=(nod and nob and a) or (d and nob and noa);
				comkc<=c;
				comjb<=(c and a) or (d and a) or (d and c); 
				comkb<=(nod and noc and noa);
				comja<=(noc and nob and noa);
				comka<=a;
			else
				comjd<=(noc and b and a);
				comkd<= (d and c) or (d and b) or (d and noc and noa);
				comjc<=(nod and nob and a);
				comkc<=c;
				comjb<=(nod and a) or (c and nob) or (d and noc and noa); 
				comkb<=(nod and noc and b);
				comja<=(nod and noc and nob) or (nod and c and b);
				comka<=(nob and a) or (d and a) or (c and a);
			end if;
	end process;

-------------------------------------

ff0A:ffjk port map(					-- Flip flop JK menos significadivo
			clk=>senal,
			clr=>clr0,
			pre=>'0',
			j=>comja,
			k=>comka,
			q=>q0(0),
			qno=>qno0(0));
			
ff0B:ffjk port map(
			clk=>senal,
			clr=>clr0,
			pre=>'0',
			j=>comjb,
			k=>comkb,
			q=>q0(1),
			qno=>qno0(1));
			
ff0C:ffjk port map(
			clk=>senal,
			clr=>clr0,
			pre=>'0',
			j=>comjc,
			k=>comkc,
			q=>q0(2),
			qno=>qno0(2));
			
ff0D:ffjk port map(
			clk=>senal,
			clr=>clr0,
			pre=>'0',
			j=>comjd,
			k=>comkd,
			q=>q0(3),
			qno=>qno0(3));

				
-- Decodificador para display de 7 segmentos
dis00:decof  port map(a=>q0,d=>dis);		
end architecture;