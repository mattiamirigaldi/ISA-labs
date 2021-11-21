library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_unsigned.all;
use WORK.constants.all;
use WORK.my_data_types.all; 

ENTITY FlipFlop IS
   PORT
   (
      d : 				IN  STD_LOGIC; 
	  clk, clr : 		IN  STD_LOGIC;
      Q : 				OUT STD_LOGIC
   );
END FlipFlop;

ARCHITECTURE behavior OF FlipFlop IS
BEGIN
   PROCESS (clk,clr)		--asynchronous reset
   BEGIN		
		IF clr = '0' THEN
			Q <= '0';
		ELSIF ( clk'EVENT and clk='1' ) THEN
			Q <= d;
		END IF; 
	END PROCESS;
END ARCHITECTURE;

