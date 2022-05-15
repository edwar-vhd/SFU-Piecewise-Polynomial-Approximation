library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LUT_C0_reci_sqrt_1_2 is
	generic(
		word_bits	:natural:=26;
		bus_bits	:natural:=29;
		add_bits	:natural:=7
	);
	port(
		addr		:in std_logic_vector(add_bits-1 downto 0);
		data		:out std_logic_vector(bus_bits-1 downto 0)
	);
end entity;

architecture behav of LUT_C0_reci_sqrt_1_2 is
	type storage is array (0 to 2**add_bits-1) of std_logic_vector(word_bits-1 downto 0);
	signal rom:storage:=(
		"11111111111111111111111110",
		"11111110000000101111101010",
		"11111100000010111101100000",
		"11111010000110100111101110",
		"11111000001011101100100000",
		"11110110010010001010001110",
		"11110100011001111111001000",
		"11110010100011001001101100",
		"11110000101101101000010000",
		"11101110111001011001010110",
		"11101101000110011011011100",
		"11101011010100101101000100",
		"11101001100100001100110110",
		"11100111110100111001010100",
		"11100110000110110001001100",
		"11100100011001110011001000",
		"11100010101101111101110110",
		"11100001000011010000000100",
		"11011111011001101000100110",
		"11011101110001000110001100",
		"11011100001001100111101110",
		"11011010100011001100000010",
		"11011000111101110010000000",
		"11010111011001011000100100",
		"11010101110101111110101000",
		"11010100010011100011001100",
		"11010010110010000101001100",
		"11010001010001100011101010",
		"11001111110001111101101000",
		"11001110010011010010001000",
		"11001100110101100000010000",
		"11001011011000100111000110",
		"11001001111100100101110000",
		"11001000100001011011011000",
		"11000111000111000111000110",
		"11000101101101101000000110",
		"11000100010100111101100010",
		"11000010111101000110101010",
		"11000001100110000010101100",
		"11000000001111110000110100",
		"10111110111010010000010100",
		"10111101100101100000011110",
		"10111100010001100000100100",
		"10111010111110001111111000",
		"10111001101011101101101110",
		"10111000011001111001011010",
		"10110111001000110010010110",
		"10110101111000010111110100",
		"10110100101000101001001110",
		"10110011011001100101111010",
		"10110010001011001101010100",
		"10110000111101011110110100",
		"10101111110000011001110100",
		"10101110100011111101110010",
		"10101101011000001010000110",
		"10101100001100111110010000",
		"10101011000010011001101010",
		"10101001111000011011110110",
		"10101000101111000100010000",
		"10100111100110010010010110",
		"10100110011110000101101100",
		"10100101010110011101110000",
		"10100100001111011010000010",
		"10100011001000111010000100",
		"10100010000010111101011010",
		"10100000111101100011100110",
		"10011111111000101100001100",
		"10011110110100010110101100",
		"10011101110000100010101110",
		"10011100101101001111110110",
		"10011011101010011101101000",
		"10011010101000001011101100",
		"10011001100110011001100110",
		"10011000100101000110111100",
		"10010111100100010011011000",
		"10010110100011111110011110",
		"10010101100100000111111010",
		"10010100100100101111010000",
		"10010011100101110100001100",
		"10010010100111010110010110",
		"10010001101001010101011000",
		"10010000101011110000111010",
		"10001111101110101000101000",
		"10001110110001111100001100",
		"10001101110101101011010000",
		"10001100111001110101100010",
		"10001011111110011010101010",
		"10001011000011011010011000",
		"10001010001000110100010110",
		"10001001001110101000010000",
		"10001000010100110101110110",
		"10000111011011011100110000",
		"10000110100010011100110000",
		"10000101101001110101100100",
		"10000100110001100110110110",
		"10000011111001110000011000",
		"10000011000010010001111000",
		"10000010001011001011000100",
		"10000001010100011011101110",
		"10000000011110000011100000",
		"01111111101000000010001110",
		"01111110110010010111101000",
		"01111101111101000011011100",
		"01111101001000000101011100",
		"01111100010011011101011000",
		"01111011011111001011000010",
		"01111010101011001110001010",
		"01111001110111100110100010",
		"01111001000100010011111010",
		"01111000010001010110000110",
		"01110111011110101100110110",
		"01110110101100010111111110",
		"01110101111010010111010000",
		"01110101001000101010011110",
		"01110100010111010001011100",
		"01110011100110001011111100",
		"01110010110101011001110000",
		"01110010000100111010101110",
		"01110001010100101110100110",
		"01110000100100110101010000",
		"01101111110101001110011110",
		"01101111000101111010000010",
		"01101110010110110111110100",
		"01101101101000000111100100",
		"01101100111001101001001100",
		"01101100001011011100011100",
		"01101011011101100001001010",
		"01101010101111110111001110"
	);
begin
	data <= "001"&rom(to_integer(unsigned(addr)));
end architecture;