library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.math_real.all;

package CONSTANTS is
	  
	constant NumBit_A 			: integer 							:= 24;
	constant NumBit_B 			: integer 							:= 24;
	constant NumBit_P 			: integer 							:= (NumBit_A + NumBit_B);

end CONSTANTS;

