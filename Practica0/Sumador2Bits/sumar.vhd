library ieee;
use ieee.std_logic_1164.all;

entity Sumador is
	port (A,B: in std_logic_vector (1 downto 0);
	      S: out std_logic_vector (1 downto 0);
	      Cf: out std_logic
	      );
	 attribute pin_numbers of Sumador: entity is
	"A(0):5 A(1):4 B(0):3 B(1):2"
	& " S(0):16 S(1):15 Cf:14";
end entity;

architecture A_Sumador of Sumador is
signal C:std_logic_vector (2 downto 0);
signal Ci:std_logic;
begin
	Ci<='0';
	C(0)<='0';
	process(A,B)
	begin
			for i in 0 to 1 loop
				S(i) <= A(i) XOR B(i) XOR C(i);
				C(i+1) <= (A(i) AND B(i)) OR (A(i) AND C(i)) OR (B(i) AND C(i));
			end loop;
	Cf<=C(2);
	end process;
end A_Sumador;