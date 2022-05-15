-----------------------------------------------------------------------------	
-- Proyecto				: 	SFU IEEE754
-- Nombre de archivo	: 	SFU.vhd
-- Titulo				: 	Special Function Unit  
-----------------------------------------------------------------------------	
-- Descripcion			: 	This unit performs the floating point operations
--						  		sin(x), cos(x), rsqrt(x), log2(x), exp2(x), 1/x, and sqrt(x), using
--								IEE754 standard and operational compliant with GPU G80
--								architecture
-----------------------------------------------------------------------------	
-- Universidad Pedagogica y Tecnologica de Colombia
-- Facultad de Ingeniería
-- Escuela de Ingenieria Electronica - Extension Tunja
-- 
-- Autor: Juan David Guerrero Balaguera; Edwar Javier Patiño Núñez
-- October 2020
-----------------------------------------------------------------------------	

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sfu is
	port(
		src1_i	:in std_logic_vector(31 downto 0); -- IEE754 input data
		selop_i	:in std_logic_vector(2 downto 0); -- Operation selection
		Result_o	:out std_logic_vector(31 downto 0); -- IEE754 result data output
		error		:out std_logic
	);
end entity;

architecture behav of sfu is 
	signal s_Result_o_1		:std_logic_vector(31 downto 0);
	signal s_Result_o_2		:std_logic_vector(31 downto 0);
	signal s_Result_o_3		:std_logic_vector(31 downto 0);
begin 
	DUT01: entity work.sfu_components
		port map(
			src1_i	=> src1_i,	 
			selop_i	=> selop_i, 
			Result_o => s_Result_o_1);
			
	DUT02: entity work.sfu_components
		port map(
			src1_i	=> src1_i,	 
			selop_i	=> selop_i, 
			Result_o => s_Result_o_2);
			
	DUT03: entity work.sfu_components
		port map(
			src1_i	=> src1_i,	 
			selop_i	=> selop_i, 
			Result_o => s_Result_o_3);
			
	voter_sfu:entity work.voter
		generic map(
			word_bits => 32
		)
		port map(
			z1		=>	s_Result_o_1,
			z2		=> s_Result_o_2,
			z3		=> s_Result_o_3,
			z		=> Result_o,
			error	=> error
		);
end architecture;