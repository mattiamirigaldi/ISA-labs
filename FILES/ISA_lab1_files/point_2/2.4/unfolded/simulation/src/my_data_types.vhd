library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_signed.all;
use IEEE.math_real.all;
use WORK.constants.all; -- libreria WORK user-defined

package my_data_types is 
	type matrix_input is array (natural range <>) of std_logic_vector (Numbit-1 downto 0);  --N-1 downto 0
	type matrix is array (natural range <>) of std_logic_vector (Numbit-1-shift downto 0);
end my_data_types;


