library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sfu_tb_2 is
end entity sfu_tb_2;

architecture verification of sfu_tb_2 is
	signal s_src1_i		:std_logic_vector(31 downto 0):=(others=>'0');
	signal s_selop_i  	:std_logic_vector(2 downto 0):=(others=>'0');
	signal s_Result_o 	:std_logic_vector(31 downto 0);

	signal lsfr_input		:std_logic_vector(31 downto 0):=X"00000001";
	signal lsfr_op	   	:std_logic_vector(3 downto 0):="1000";

	signal s_sel_phase 	:std_logic :='0';
	signal s_rro_result	:std_logic_vector(31 downto 0):=(others=>'0');

	signal s_sfu_input 	:std_logic_vector(31 downto 0):=(others=>'0');
begin
	s_sel_phase <= '1' when s_selop_i = "100" else '0';

	UUT: entity work.rro
		port map(
			selec_phase => s_sel_phase,
			input       => s_src1_i,
			Result      => s_rro_result);

	s_sfu_input <=	s_rro_result when s_selop_i="000" else -- sin(x)
						s_rro_result when s_selop_i="001" else -- cos(x)
						s_rro_result when s_selop_i="100" else -- 2^x
						s_src1_i;

	DUT: entity work.sfu
		port map(
			src1_i	=> s_sfu_input,	 
			selop_i	=> s_selop_i, 
			Result_o => s_Result_o);

	s_selop_i	<= "000";
	s_src1_i 	<= X"C3012443";
end architecture;