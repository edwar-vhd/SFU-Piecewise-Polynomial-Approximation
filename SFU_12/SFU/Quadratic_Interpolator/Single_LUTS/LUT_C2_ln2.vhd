library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LUT_C2_ln2 is
	generic(
		word_bits	:natural:=13;
		bus_bits	:natural:=14;
		add_bits	:natural:=7
	);
	port(
		addr		:in std_logic_vector(add_bits-1 downto 0);
		data		:out std_logic_vector(bus_bits-1 downto 0)
	);
end entity;

architecture behav of LUT_C2_ln2 is
	type storage is array (0 to 2**add_bits-1) of std_logic_vector(word_bits-1 downto 0);
	signal rom:storage:=(
		"1011011100000",
		"1011010001000",
		"1011000110000",
		"1010111011000",
		"1010110001000",
		"1010100111000",
		"1010011100000",
		"1010010011000",
		"1010001001000",
		"1010000000000",
		"1001110110000",
		"1001101101000",
		"1001100101000",
		"1001011100000",
		"1001010011000",
		"1001001011000",
		"1001000011000",
		"1000111011000",
		"1000110011000",
		"1000101100000",
		"1000100100000",
		"1000011101000",
		"1000010110000",
		"1000001111000",
		"1000001000000",
		"1000000001000",
		"0111111011000",
		"0111110100000",
		"0111101110000",
		"0111100111000",
		"0111100001000",
		"0111011011000",
		"0111010101000",
		"0111010000000",
		"0111001010000",
		"0111000100000",
		"0110111111000",
		"0110111001000",
		"0110110100000",
		"0110101111000",
		"0110101010000",
		"0110100101000",
		"0110100000000",
		"0110011011000",
		"0110010110000",
		"0110010010000",
		"0110001101000",
		"0110001000000",
		"0110000100000",
		"0110000000000",
		"0101111011000",
		"0101110111000",
		"0101110011000",
		"0101101111000",
		"0101101011000",
		"0101100111000",
		"0101100011000",
		"0101011111000",
		"0101011011000",
		"0101011000000",
		"0101010100000",
		"0101010001000",
		"0101001101000",
		"0101001010000",
		"0101000110000",
		"0101000011000",
		"0100111111000",
		"0100111100000",
		"0100111001000",
		"0100110110000",
		"0100110011000",
		"0100110000000",
		"0100101101000",
		"0100101010000",
		"0100100111000",
		"0100100100000",
		"0100100001000",
		"0100011110000",
		"0100011011000",
		"0100011001000",
		"0100010110000",
		"0100010011000",
		"0100010001000",
		"0100001110000",
		"0100001100000",
		"0100001001000",
		"0100000111000",
		"0100000100000",
		"0100000010000",
		"0011111111000",
		"0011111101000",
		"0011111011000",
		"0011111000000",
		"0011110110000",
		"0011110100000",
		"0011110010000",
		"0011110000000",
		"0011101101000",
		"0011101011000",
		"0011101001000",
		"0011100111000",
		"0011100101000",
		"0011100011000",
		"0011100001000",
		"0011011111000",
		"0011011101000",
		"0011011100000",
		"0011011010000",
		"0011011000000",
		"0011010110000",
		"0011010100000",
		"0011010010000",
		"0011010001000",
		"0011001111000",
		"0011001101000",
		"0011001100000",
		"0011001010000",
		"0011001000000",
		"0011000111000",
		"0011000101000",
		"0011000011000",
		"0011000010000",
		"0011000000000",
		"0010111111000",
		"0010111101000",
		"0010111100000",
		"0010111010000",
		"0010111001000"
	);
begin
	data <= "1"&rom(to_integer(unsigned(addr)));
end architecture;