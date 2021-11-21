library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_unsigned.all;
use IEEE.Numeric_Std.all;
use WORK.constants.all;
use WORK.my_data_types.all; 

ENTITY processing_unit IS
	GENERIC (Nb : INTEGER := Numbit;
			 s  : INTEGER := shift;
			 N  : INTEGER := Nt);
	PORT (
		input_data   : in  matrix (N downto 0);
		coefficient  : in  matrix (N downto 0);
		clk, en 	 : in  std_logic;
		out_en 		 : out std_logic;
		result       : out std_logic_vector (Nb-1 downto 0));
END processing_unit; 

ARCHITECTURE behavior OF processing_unit IS 
		  
BEGIN 
	PROCESS(clk)
	variable result_tmp : signed (Nb-s downto 0);	
	variable mult_tmp 	: signed (2*(Nb-s)-1 downto 0);
	BEGIN 	
		IF ( clk'EVENT and clk='1') THEN
			IF ( en = '1') THEN 
				result_tmp := (others =>'0');
				FOR i IN 0 TO N LOOP 
					mult_tmp := signed(input_data(i))*signed(coefficient(i));
					result_tmp := signed(result_tmp) + mult_tmp ( 2*(Nb-s)-1 downto (Nb-s-1) );
					--result_tmp := to_signed((to_integer(signed(result_tmp)) + to_integer(signed(input_data(i)))*to_integer(signed(coefficient(i)))),result_tmp'length);
				END LOOP;	
				out_en <= '1';
				result <= std_logic_vector(result_tmp)&(s-2 downto 0 => '0'); 			
			ELSE 
				out_en <= '0';
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;
