library ieee;
use ieee.std_logic_1164.all;
library lattice;
use lattice.all;

entity coder00 is
port(
	clkc: in std_logic;
	inkeyc: in std_logic_vector(3 downto 0);
	incontc: inout std_logic_vector(3 downto 0);
	outcoderc: out std_logic_vector(6 downto 0)
);
end coder00;

architecture coder0 of coder00 is
begin
	pcoder: process(clkc)
	variable aux0: bit:='0';
	variable aux1: bit:='0';
	variable aux2: bit:='0';
	variable aux3: bit:='0';
	begin
		if(clkc'event and clkc = '1') then
			case incontc is
	---------------------------- Fila 1 ---------------------------------------------------		
				when "1000" => 
					case inkeyc is
						when "0000" =>
								aux0:='0';
						when "1000" =>
							if (aux0 = '0') then
								aux0:='1';
								outcoderc <= "0110000";-- 1
							end if;
						when "0100" =>
							if (aux0 = '0') then
								aux0:='1';
								outcoderc <= "1101101";-- 2
							end if;
						when "0010" =>
							if (aux0 = '0') then
								aux0:='1';
								outcoderc <= "1111001";-- 3
							end if;
						when "0001" =>
							if (aux0 = '0') then
								aux0:='1';
								outcoderc <= "1110111";-- A
							end if;
						when others => null;
					end case;
	---------------------------- Fila 2 ---------------------------------------------------				
				when "0100" => 
					case inkeyc is
						when "0000" =>
								aux1:='0';
						when "1000" =>
							if (aux1 = '0') then
								aux1:='1';
								outcoderc <= "0110011";-- 4
							end if;
						when "0100" =>
							if (aux1 = '0') then
								aux1:='1';
								outcoderc <= "1011011";-- 5
							end if;
						when "0010" =>
							if (aux1 = '0') then
								aux1:='1';
								outcoderc <= "1011111";-- 6 
							end if;
						when "0001" =>
							if (aux1 = '0') then
								aux1:='1';
								outcoderc <= "0011111";-- b
							end if;
						when others => null;
					end case;
	---------------------------- Fila 3 ---------------------------------------------------		
				when "0010" => 
					case inkeyc is
						when "0000" =>
								aux2:='0';
						when "1000" =>
							if (aux2 = '0') then
								aux2:='1';
								outcoderc <= "1110000";-- 7
							end if;
						when "0100" =>
							if (aux2 = '0') then
								aux2:='1';
								outcoderc <= "1111111";-- 8
							end if;
						when "0010" =>
							if (aux2 = '0') then
								aux2:='1';
								outcoderc <= "1110011";-- 9
							end if;
						when "0001" =>
							if (aux2 = '0') then
								aux2:='1';
								outcoderc <= "1001110";-- C
							end if;
						when others => null;
					end case;
	---------------------------- Fila 4 ---------------------------------------------------		
				when "0001" => 
					case inkeyc is
						when "0000" =>
								aux3:='0';
						when "0100" =>
							if (aux3 = '0') then
								aux3:='1';
								outcoderc <= "1111110";-- 0
							end if;
						when "1000" =>
							if (aux3 = '0') then
								aux3:='1';
								outcoderc <= "1100011";-- *
							end if;
						when "0010" =>
							if (aux3 = '0') then
								aux3:='1';
								outcoderc <= "0011101";-- #
							end if;
						when "0001" =>
							if (aux3 = '0') then
								aux3:='1';
								outcoderc <= "0111101";-- b
							end if;
						when others => null;
					end case;
				when others => null;
			end case;
		end if;		
	end process pcoder;
end coder0;