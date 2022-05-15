library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all; -- require for writing/reading std_logic etc

entity sfu_tb is
end entity sfu_tb;

architecture verification of sfu_tb is 
	file f_input_sin  		:text;
	file f_input_cos  		:text;
	file f_input_rsqrt  		:text;
	file f_input_log2  		:text;
	file f_input_ex2   		:text;
	file f_input_rcp   		:text;
	file f_input_sqrt   		:text;

	file f_output_sin 		:text;
	file f_output_cos			:text;
	file f_output_rsqrt 		:text;
	file f_output_log2 		:text;
	file f_output_ex2 		:text;
	file f_output_rcp 		:text;
	file f_output_sqrt 		:text;
	
	signal s_clk_i	 			:std_logic:='1';
	signal s_src1_i	 		:std_logic_vector(31 downto 0):=(others=>'0');
	signal s_selop_i  		:std_logic_vector(2 downto 0):=(others=>'0');
	signal s_Result_o 		:std_logic_vector(31 downto 0);

	signal s_sel_phase 		:std_logic:='0';
	signal s_rro_result 		:std_logic_vector(31 downto 0):=(others=>'0');

	signal s_sfu_input 		:std_logic_vector(31 downto 0):=(others=>'0');
begin 	
	s_sel_phase <= '1' when s_selop_i="100" else '0';

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

	clk_gen: process
		variable index :integer:=280112; --(20008*7*2)
	begin
		for i in 1 to index loop
			wait for 50 ns;
			s_clk_i <= not s_clk_i;
		end loop;
		
		wait;
	end process;

	data_gen:process
		variable v_i_line   	:line;	-- Read lines one by one from f_input
		variable v_o_line   	:line; 	-- Write lines one by one to f_output
		variable v_x	  		:std_logic_vector(31 downto 0); -- Valor de entrada
		variable v_comma		:character;

		variable v_character	:character;
		variable hex_val    	:std_logic_vector(3 downto 0);
		variable offset     	:integer;
	begin
		-- Open files
		file_open(f_input_sin,  	"./SFU_Input_data/input_sin.csv", 	read_mode);
		file_open(f_input_cos,  	"./SFU_Input_data/input_cos.csv", 	read_mode);
		file_open(f_input_rsqrt,	"./SFU_Input_data/input_rsqrt.csv", read_mode);
		file_open(f_input_log2, 	"./SFU_Input_data/input_log2.csv", 	read_mode);
		file_open(f_input_ex2, 		"./SFU_Input_data/input_ex2.csv", 	read_mode);
		file_open(f_input_rcp, 		"./SFU_Input_data/input_rcp.csv", 	read_mode);
		file_open(f_input_sqrt,		"./SFU_Input_data/input_sqrt.csv", 	read_mode);
	  
		file_open(f_output_sin,		"./SFU_Input_data/output_sin.csv", 	write_mode); 
		file_open(f_output_cos,  	"./SFU_Input_data/output_cos.csv", 	write_mode); 
		file_open(f_output_rsqrt,	"./SFU_Input_data/output_rsqrt.csv",write_mode); 
		file_open(f_output_log2, 	"./SFU_Input_data/output_log2.csv", write_mode); 
		file_open(f_output_ex2,  	"./SFU_Input_data/output_ex2.csv", 	write_mode); 
		file_open(f_output_rcp,  	"./SFU_Input_data/output_rcp.csv", 	write_mode); 
		file_open(f_output_sqrt, 	"./SFU_Input_data/output_sqrt.csv",	write_mode); 
				
		-----------------------------------------------------------------------------
		--========================SIN================================================
		-----------------------------------------------------------------------------
		-- Encabezado de texto
		write(v_o_line, string'("Input,Sin,RRO_output"));
		writeline(f_output_sin,v_o_line);
		-----------------------------------------------------------------------------
		readline(f_input_sin, v_i_line);		-- Se omite linea de encabezado
		while not endfile(f_input_sin) loop
			readline(f_input_sin, v_i_line);  	
			-- Lectura de hexadecimal
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

			-- Iniciar calculo
			s_selop_i 	<= "000";
			s_src1_i 	<= v_x;
			wait until falling_edge(s_clk_i);
			
			-- Escribir resultados
			hwrite(v_o_line, s_src1_i);
			write(v_o_line, string'(","));
			hwrite(v_o_line, s_Result_o);
			write(v_o_line, string'(","));
			hwrite(v_o_line, s_sfu_input);
			writeline(f_output_sin, v_o_line);
			
			wait until rising_edge(s_clk_i);
		end loop;

		-----------------------------------------------------------------------------
		--========================COS================================================
		-----------------------------------------------------------------------------
		write(v_o_line, string'("Input,cos,RRO_output")); -- Encabezado de texto
		writeline(f_output_cos, v_o_line);
		-----------------------------------------------------------------------------
		readline(f_input_cos, v_i_line);		-- Se omite linea de encabezado
		while not endfile(f_input_cos) loop
			readline(f_input_cos, v_i_line);  	
			-- Lectura de hexadecimal
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

			-- Iniciar calculo
			s_selop_i <= "001";
			s_src1_i <= v_x;
			wait until falling_edge(s_clk_i);
			
			-- Escribir resultados
			hwrite(v_o_line, s_src1_i);
			write(v_o_line, string'(","));
			hwrite(v_o_line, s_Result_o);
			write(v_o_line, string'(","));
			hwrite(v_o_line, s_sfu_input);
			writeline(f_output_cos, v_o_line);

			wait until rising_edge(s_clk_i);
		end loop;
	  
		-----------------------------------------------------------------------------
		--========================RSQRT==============================================
		-----------------------------------------------------------------------------
		-- Encabezado de texto
		write(v_o_line, string'("Input,rsqrt"));
		writeline(f_output_rsqrt, v_o_line);
		-----------------------------------------------------------------------------
		readline(f_input_rsqrt, v_i_line);		-- Se omite linea de encabezado
		while not endfile(f_input_rsqrt) loop
			readline(f_input_rsqrt, v_i_line);  	
			-- Lectura de hexadecimal
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

			-- Iniciar calculo
			s_selop_i <= "010";
			s_src1_i <= v_x;
			wait until falling_edge(s_clk_i);
			
			-- Escribir resultados
			hwrite(v_o_line, s_src1_i);
			write(v_o_line, string'(","));
			hwrite(v_o_line, s_Result_o);
			writeline(f_output_rsqrt, v_o_line);

			wait until rising_edge(s_clk_i);
		end loop;
	  
		-----------------------------------------------------------------------------
		--========================LOG2===============================================
		-----------------------------------------------------------------------------
		 -- Encabezado de texto
		write(v_o_line, string'("Input,log2"));
		writeline(f_output_log2, v_o_line);
		-----------------------------------------------------------------------------
		readline(f_input_log2, v_i_line);		-- Se omite linea de encabezado
		while not endfile(f_input_log2) loop
			readline(f_input_log2, v_i_line);  	
			-- Lectura de hexadecimal
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

			-- Iniciar calculo
			s_selop_i <= "011";
			s_src1_i <= v_x;
			wait until falling_edge(s_clk_i);
			
			-- Escribir resultados
			hwrite(v_o_line, s_src1_i);
			write(v_o_line, string'(","));
			hwrite(v_o_line, s_Result_o);
			writeline(f_output_log2, v_o_line);

			wait until rising_edge(s_clk_i);
		end loop;
	  
		-----------------------------------------------------------------------------
		--========================EX22===============================================
		-----------------------------------------------------------------------------
		-- Encabezado de texto
		write(v_o_line, string'("Input,ex2,RRO_output"));
		writeline(f_output_ex2, v_o_line);
		-----------------------------------------------------------------------------
		readline(f_input_ex2, v_i_line);		-- Se omite linea de encabezado
		while not endfile(f_input_ex2) loop
			readline(f_input_ex2, v_i_line);  	
			-- Lectura de hexadecimal
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

			-- Iniciar calculo
			s_selop_i <= "100";
			s_src1_i <= v_x;
			wait until falling_edge(s_clk_i);
			
			-- Escribir resultados
			hwrite(v_o_line, s_src1_i);
			write(v_o_line, string'(","));
			hwrite(v_o_line, s_Result_o);
			write(v_o_line, string'(","));
			hwrite(v_o_line, s_sfu_input);
			writeline(f_output_ex2, v_o_line);

			wait until rising_edge(s_clk_i);
		end loop;
	  
		-----------------------------------------------------------------------------
		--========================RCP================================================
		-----------------------------------------------------------------------------
		-- Encabezado de texto
		write(v_o_line, string'("Input,ex2"));
		writeline(f_output_rcp, v_o_line);
		-----------------------------------------------------------------------------
		readline(f_input_rcp, v_i_line);		-- Se omite linea de encabezado
		while not endfile(f_input_rcp) loop
			readline(f_input_rcp, v_i_line);  	
			-- Lectura de hexadecimal
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

			-- Iniciar calculo
			s_selop_i <= "101";
			s_src1_i <= v_x;
			wait until falling_edge(s_clk_i);
			
			-- Escribir resultados
			hwrite(v_o_line, s_src1_i);
			write(v_o_line, string'(","));
			hwrite(v_o_line, s_Result_o);
			writeline(f_output_rcp, v_o_line);

			wait until rising_edge(s_clk_i);
		end loop;

		-----------------------------------------------------------------------------
		--========================SQRT===============================================
		-----------------------------------------------------------------------------
		-- Encabezado de texto
		write(v_o_line, string'("Input,ex2"));
		writeline(f_output_sqrt, v_o_line);
		-----------------------------------------------------------------------------
		readline(f_input_sqrt, v_i_line);		-- Se omite linea de encabezado
		while not endfile(f_input_sqrt) loop
			readline(f_input_sqrt, v_i_line);  	
			-- Lectura de hexadecimal
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
		
			-- Iniciar calculo
			s_selop_i <= "110";
			s_src1_i <= v_x;
			wait until falling_edge(s_clk_i);
			
			-- Escribir resultados
			hwrite(v_o_line, s_src1_i);
			write(v_o_line, string'(","));
			hwrite(v_o_line, s_Result_o);
			writeline(f_output_sqrt, v_o_line);

			wait until rising_edge(s_clk_i);
		end loop;
		
		-----------------------------------------------------------------------------
		--===========================================================================
		-----------------------------------------------------------------------------
		-- Close  files
		file_close(f_input_sin);
		file_close(f_input_cos);
		file_close(f_input_rsqrt);
		file_close(f_input_log2);
		file_close(f_input_ex2);
		file_close(f_input_rcp);
		file_close(f_input_sqrt);
	  
		file_close(f_output_sin);
		file_close(f_output_cos);
		file_close(f_output_rsqrt);
		file_close(f_output_log2);
		file_close(f_output_ex2);
		file_close(f_output_rcp);
		file_close(f_output_sqrt);		

		report "Simulation finished.....";
		wait;
	end process;	
end architecture;