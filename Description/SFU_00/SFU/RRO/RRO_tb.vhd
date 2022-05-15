
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing/reading std_logic etc

entity RRO_tb is
end entity RRO_tb;

architecture verification of RRO_tb is 
	file f_input_sin  : text;
	file f_input_cos  : text;

	file f_output_sin : text;
	file f_output_cos: text;


	signal s_clk_i	  	: std_logic :='0';
	signal s_reset_n	  	: std_logic :='0';
	signal s_selec_phase  : std_logic :='0';
	signal s_input        : std_logic_vector(31 downto 0) :=(others=>'0');
	signal s_quad		  	: std_logic_vector(1 downto 0);
	signal s_Result       : std_logic_vector(31 downto 0);
	
begin 

	DUT: entity work.RRO
		port map(
					selec_phase  => s_selec_phase,
					input        => s_input,      
					Result       => s_Result);     
		
	s_quad <= s_Result(30 downto 29);
	clk_gen: process
			begin
				wait for 50 ns;
				s_clk_i <= not s_clk_i;
			end process;
		
	rst_gen: process
			begin
				wait for 500 ns;
				s_reset_n <= '1';
				wait;
			end process;	

	gata_gen:process
		 variable v_i_line   : line;	-- read lines one by one from f_input
		 variable v_o_line   : line; -- write lines one by one to f_output
		 variable v_x	  : std_logic_vector(31 downto 0); -- valor de entrada
		 variable v_comma		: character;

		 variable v_character: character;
		 variable hex_val    : std_logic_vector(3 downto 0);
		 variable offset     : integer;

	  begin

	  -- open files
	  file_open(f_input_sin, "RRO_input_data_sin.csv", read_mode);
	  file_open(f_input_cos, "RRO_input_data_cos.csv", read_mode);
	  
	  file_open(f_output_sin, "out_rro_HW_sin.csv", write_mode); 
	  file_open(f_output_cos, "out_rro_HW_cos.csv", write_mode);  

		wait on s_clk_i until s_reset_n='1';
	  --========================SIN=============================================	
	  -- encabezado de texto
	  write(v_o_line, string'("input_data,reduced_angle,quadrant"));
	  writeline(f_output_sin, v_o_line);
	  -----------------------------------------------------------------------------
	  readline(f_input_sin, v_i_line);		-- se omite linea de encabezado
	  while not endfile(f_input_sin) loop
		readline(f_input_sin, v_i_line);  	
		-- lectura de hexadecimal
		 offset := 0;
		 while offset < v_x'left loop
			read(v_i_line, v_character);
			case v_character is
			  when '0' => hex_val := "0000";
				when '1' => hex_val := "0001";
				when '2' => hex_val := "0010";
				when '3' => hex_val := "0011";
				when '4' => hex_val := "0100";
				when '5' => hex_val := "0101";
				when '6' => hex_val := "0110";
				when '7' => hex_val := "0111";
				when '8' => hex_val := "1000";
				when '9' => hex_val := "1001";
				when 'A' | 'a' => hex_val := "1010";
				when 'B' | 'b' => hex_val := "1011";
				when 'C' | 'c' => hex_val := "1100";
				when 'D' | 'd' => hex_val := "1101";
				when 'E' | 'e' => hex_val := "1110";
				when 'F' | 'f' => hex_val := "1111";
				when others 	=>	hex_val := "XXXX";
				 assert false report "Found non-hex character '" & v_character & "'";
			end case;
			v_x(v_x'left - offset downto v_x'left-offset-3) := hex_val;
			offset := offset + 4;
		 end loop;

		 -- iniciar calculo
		 s_input <= v_x;
		wait until falling_edge(s_clk_i);
		 -- escribir resultados
		 hwrite(v_o_line, s_input);
		 write(v_o_line, string'(","));
		 hwrite(v_o_line, s_Result);
		write(v_o_line, string'(","));
		 hwrite(v_o_line, s_quad);
		 writeline(f_output_sin, v_o_line);
		wait until falling_edge(s_clk_i);
	  end  loop;
	  --file_close(f_output_sin);
	  file_close(f_input_sin);
	  file_open(f_input_cos, "RRO_input_data_cos.csv", read_mode);
	  --========================COS=============================================
		-- encabezado de texto
	  write(v_o_line, string'("input_data,reduced_angle,quadrant"));
	  writeline(f_output_cos, v_o_line);
	  -----------------------------------------------------------------------------
	  readline(f_input_cos, v_i_line);		-- se omite linea de encabezado
	  while not endfile(f_input_cos) loop
		readline(f_input_cos, v_i_line);  	
		-- lectura de hexadecimal
		 offset := 0;
		 while offset < v_x'left loop
			read(v_i_line, v_character);
			case v_character is
			  when '0' => hex_val := "0000";
				when '1' => hex_val := "0001";
				when '2' => hex_val := "0010";
				when '3' => hex_val := "0011";
				when '4' => hex_val := "0100";
				when '5' => hex_val := "0101";
				when '6' => hex_val := "0110";
				when '7' => hex_val := "0111";
				when '8' => hex_val := "1000";
				when '9' => hex_val := "1001";
				when 'A' | 'a' => hex_val := "1010";
				when 'B' | 'b' => hex_val := "1011";
				when 'C' | 'c' => hex_val := "1100";
				when 'D' | 'd' => hex_val := "1101";
				when 'E' | 'e' => hex_val := "1110";
				when 'F' | 'f' => hex_val := "1111";
				when others 	=>	hex_val := "XXXX";
				 assert false report "Found non-hex character '" & v_character & "'";
			end case;
			v_x(v_x'left - offset downto v_x'left-offset-3) := hex_val;
			offset := offset + 4;
		 end loop;

		 -- iniciar calculo
		 s_input <= v_x;
		wait until falling_edge(s_clk_i);
		 -- escribir resultados
		 hwrite(v_o_line, s_input);
		 write(v_o_line, string'(","));
		 hwrite(v_o_line, s_Result);
		write(v_o_line, string'(","));
		 hwrite(v_o_line, s_quad);
		 writeline(f_output_cos, v_o_line);
		wait until falling_edge(s_clk_i);
	  end  loop;
	  
		-- Close files
		file_close(f_input_sin);
		file_close(f_input_cos);
		file_close(f_output_sin );
		file_close(f_output_cos );
	wait;
	end process;		
end architecture;