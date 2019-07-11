library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library latice;
use latice.all;
library machxo2;
use machxo2.all;
use paquete.all;

entity sensor is
	port(sensor: in std_logic_vector(1 downto 0); -- simulacion de los dos sensores a traves de los botones pines 109 y 112
		 ledS,ledR,ena: inout std_logic; -- LedS Indica entrada/salida de persona, LedR va a ir conforme al reloj
		display: out std_logic_vector(6 downto 0) ); -- Display en teoria sera la salida del contador 
end sensor;

architecture Asensor of sensor is
type edo is (e0,e1,e2,e3,e4,e5,e6,e7,e8);   -- Definicion de los estados a utilizar  
signal edo_pre, edo_sig:edo;  
signal persona,sosc,senal,f: std_logic;   -- Persona de momento no se ocupa pero sera el incremento o decremento en el contador 
begin

ena<='1';	-- Habilitador de multipelxores

-- Oscilador de la tarjeta
ca02:osc00 port map (osc_int=>sosc);	

--Divisor para el reloj
ca01:div00 port map (
			clkdiv=>sosc,
			outdiv=>senal);
			
ledR<=senal;   -- led que parpadea con el ciclo de reloj

-- Avance de estados
avance:process(senal,edo_pre,edo_sig,sensor)
begin
	if(senal'event and senal='1') then
		edo_pre<=edo_sig;
	end if;
end process;

maquina: process (sensor, edo_pre, edo_sig,persona,ledS)
begin
	case edo_pre is 
		when e0=>
			case sensor is
				when "00" => 
					edo_sig<= e0; 
					ledS<='0'; -- led de Salida que lo apaga una vez la persona entre o salga (prueba de momento) 
				when "10" => edo_sig<= e1;  --detecta el primer sensor (entra)
				when "01" => edo_sig<= e4;  --detecta el segundo sensor (persona saldria)
				when "11" => edo_sig<= e7;  -- dos personas se encuentran una sale y otra entra
				when others=>f<='0';
			end case;
		when e1=>
			case sensor is
				when "11" => edo_sig<=e2;  --persona continua entrando y lo detecta los dos sensores
				when "00" => edo_sig<=e0; -- La persona se regresa xD
				when others => edo_sig<=e1;  -- Cassos no validos y se queda en el mismo estado
			end case;
		when e2=>
			case sensor is 
				when "01" => edo_sig<=e3; -- Sigue entrando, solo lo detecta el segundo sensor
				when "10" => edo_sig<=e1; -- persona se arrepiente y se regresa xD
				when others => edo_sig<=e2;  -- Cassos no validos y se queda en el mismo estado
			end case;
		when e3=>
			case sensor is
				when "11" => edo_sig<=e2;  -- Persona se arrepiente y se regresa
				when "00" =>  -- persona finalmente entro
					edo_sig<=e0; -- al haber eentrado se regresa al estado cero
					persona<='1';  -- aqui se supone persona incrementería en 1 para despues afectar al contador 
					ledS<= '1';    -- Indicador que la persona entro (de momento)
				when others => edo_sig<=e3; -- Cassos no validos y se queda en el mismo estado
			end case;
		when e4=>
			case sensor is 
				when "11" => edo_sig<=e5; -- La persona saldra y se activan los dos sensores 
				when "00" => edo_sig<=e0; -- Persona se arrepiente y no sale xD
				when others => edo_sig<=e4;  -- Cassos no validos y se queda en el mismo estado
			end case;
		when e5=>
			case sensor is 
				when "10" => edo_sig<=e6; -- Persona se dispone a salir y ya nada mas lo detecta el primer sensor
				when "01" => edo_sig<=e4;   -- Persona indecisa no quiere salir
				when others => edo_sig<=e5;  -- Cassos no validos y se queda en el mismo estado
			end case;
		when e6=>
			case sensor is 
				when "11"=> edo_sig<=e5; --Persona se arrepiente y se regresa
				when "00"=> 
					edo_sig<=e0; -- Sale la persona y la maquina regresa al estado 0
					persona<='1';  -- la persona decrementaria uno para mandor al contador (display)
					ledS<='1'; -- Indicador que la persona salio (de momento)
				when others => edo_sig<=e6; -- Cassos no validos y se queda en el mismo estado
			end case;
		when e7=>
			case sensor is
				when "00" => edo_sig<=e0; --Ninguna de las dos personas que se encontraron de frente sale o entra xD
				when "10" => edo_sig<=e1; -- Modo Patriarcado xD Primero saldría la persona antes de que la otra entre
				when "01" => edo_sig<=e4; -- Modo Caballeroso :O Permite la salida antes de entrar
				when others => edo_sig<=e7; -- Cassos no validos y se queda en el mismo estado
			end case;
		when others=>f<='0';
	end case;
end process;
end architecture;