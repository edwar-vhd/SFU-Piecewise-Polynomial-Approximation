library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity voter is
	generic(
		word_bits	:natural:=2
	);
	port(
		z1, z2, z3	: in std_logic_vector(word_bits-1 downto 0);
		z				: out std_logic_vector(word_bits-1 downto 0);
		error			: out std_logic
	);
end entity;

architecture behav of voter is
	signal match_12, match_23, match_13 :std_logic;
begin

	match_process: process (z1,z2,z3)
	begin
		for i in 1 to word_bits-1 loop
			match_12 <= (z1(i) xnor z2(i)) and (z1(i-1) xnor z2(i-1));
			match_23 <= (z2(i) xnor z3(i)) and (z2(i-1) xnor z3(i-1));
			match_13 <= (z1(i) xnor z3(i)) and (z1(i-1) xnor z3(i-1));
		end loop;
	end process;
	
	error <= not(match_12 or match_23 or match_13);
	
	out_process: process(z1,z2,match_13)
	begin
		for i in 0 to word_bits-1 loop
			z(i) <= (match_13 and z1(i)) or (not(match_13) and z2(i));
		end loop;
	end process;
end architecture;