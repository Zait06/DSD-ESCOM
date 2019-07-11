library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;
use paquete.all;

entity desplaza is
	port(led:out std_logic;
		 ena:inout std_logic_vector(3 downto 0);
		 dis:inout std_logic_vector(6 downto 0));
end entity;

architecture com_desplaza of desplaza is
	signal p,a,l,o,salida:std_logic_vector(6 downto 0);
	type letras is (e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17);
	signal clk1,clk2,sosc:std_logic; -- Reloj
	signal edo_pre,edo_sig:letras;
	signal let_pre,let_sig:letras;
	-- Se usarán dos reloj, ya que uno nos ayudará a desplazar el letrero (clk1) y el otro
	-- nos ayudará a tener fija las letras (clk2).
	-- El reloj clk2 tiene una frecuencia de 3.4181 KHz y el clk1 tiene 1 KHz
begin
	-- Letras
	p<="1100111";
	a<="1110111";
	l<="0001110";
	o<="1111110";
	
	-- Oscilador de la tarjeta
	ca00:osc00 port map (osc_int=>sosc);
	
	-- Divisor para el desplazamiento
	ca01:div00 port map (
				clkdiv=>sosc,
				outdiv=>clk1);

	-- Divisor para el mensaje
	ca02:div01 port map (
				clkdiv1=>sosc,
				outdiv1=>clk2);
				
	led<=clk1;
				
	-- Avance de maquina de maquinas
	avance1:process(clk1,edo_pre,edo_sig)
	begin
		if(clk1'event and clk1='1') then
			edo_pre<=edo_sig;
		end if;
	end process;
	
	-- Avance de maquina de letras
	avance2:process(clk2,let_pre,let_sig)
	begin
		if(clk2'event and clk2='1') then
			let_pre<=let_sig;
		end if;
	end process;
	
	-- Maquina de estado del desplazamiento
	maquina1:process(edo_pre,edo_sig,let_pre,let_sig,ena)
	begin
		case edo_pre is
			when e0=>
				ena<="0000";
				edo_sig<=e1;
			when e1=>
				ena<="1000";
				salida<=o;
				edo_sig<=e2;
			when e2=>
				edo_sig<=e4;
				let_sig<=e2;
				case let_pre is
					when e2=>
						ena<="1000";
						salida<=l;
						let_sig<=e3;
					when e3=>
						ena<="0100";
						salida<=o;
						let_sig<=e2;
					when others=>ena<="1111";
				end case;
			when e3=>
				edo_sig<=e4;
			when e4=>
				edo_sig<=e7;
				let_sig<=e4;
				case let_pre is
					when e4=>
						ena<="1000";
						salida<=a;
						let_sig<=e5;
					when e5=>
						ena<="0100";
						salida<=l;
						let_sig<=e6;
					when e6=>
						ena<="0010";
						salida<=o;
						let_sig<=e4;
					when others=>ena<="1111";
				end case;
			when e5=>
				edo_sig<=e7;
			when e6=>
				edo_sig<=e7;
			when e7=>
				edo_sig<=e11;
				let_sig<=e7;
				case let_pre is
					when e7=>
						ena<="1000";
						salida<=p;
						let_sig<=e8;
					when e8=>
						ena<="0100";
						salida<=a;
						let_sig<=e9;
					when e9=>
						ena<="0010";
						salida<=l;
						let_sig<=e10;
					when e10=>
						ena<="0001";
						salida<=o;
						let_sig<=e7;
					when others=>ena<="1111";
				end case;
			when e8=>
				edo_sig<=e11;
			when e9=>
				edo_sig<=e11;
			when e10=>
				edo_sig<=e11;
			when e11=>
				edo_sig<=e14;
				let_sig<=e11;
				case let_pre is
					when e11=>
						ena<="0100";
						salida<=p;
						let_sig<=e12;
					when e12=>
						ena<="0010";
						salida<=a;
						let_sig<=e13;
					when e13=>
						ena<="0001";
						salida<=l;
						let_sig<=e11;
					when others=>ena<="1111";
				end case;
			when e12=>
				edo_sig<=e14;
			when e13=>
				edo_sig<=e14;
			when e14=>
				edo_sig<=e16;
				let_sig<=e14;
				case let_pre is
					when e14=>
						ena<="0010";
						salida<=p;
						let_sig<=e15;
					when e15=>
						ena<="0001";
						salida<=a;
						let_sig<=e14;
					when others=>ena<="1111";
				end case;
			when e15=>
				edo_sig<=e16;
			when e16=>
				ena<="0001";
				salida<=p;
				edo_sig<=e0;
			when others=>ena<="1111";
		end case;
	end process;

	dis<=salida;
	
end architecture;