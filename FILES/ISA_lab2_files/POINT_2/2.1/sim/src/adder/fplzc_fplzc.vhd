--
-- VHDL Architecture HAVOC.FPlzc.FPlzc
--
-- Created:
--          by - Guillermo
--          at - ITESM, 08:25:27 07/20/03
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2002.1b (Build 7)
--
-- hds interface_start
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY FPlzc IS
   PORT( 
      word  : IN     std_logic_vector (26 DOWNTO 0);
      zero  : OUT    std_logic;
      count : OUT    std_logic_vector (4 DOWNTO 0)
   );

-- Declarations

END FPlzc ;


-- hds interface_end
ARCHITECTURE FPlzc OF FPlzc IS
BEGIN

PROCESS(word)
BEGIN
	zero <= '0';
--	IF (word="0000000000000000000000000000") THEN 
--		count <= "11100";
	IF (word(26 DOWNTO 0)="000000000000000000000000000") THEN 
	   count <= "11011";
		zero <= '1';
	ELSIF (word(26 DOWNTO 1)="00000000000000000000000000") THEN count <= "11010";
	ELSIF (word(26 DOWNTO 2)="0000000000000000000000000") THEN count <= "11001";
	ELSIF (word(26 DOWNTO 3)="000000000000000000000000") THEN count <= "11000";
	ELSIF (word(26 DOWNTO 4)="00000000000000000000000") THEN count <= "10111";
	ELSIF (word(26 DOWNTO 5)="0000000000000000000000") THEN count <= "10110";
	ELSIF (word(26 DOWNTO 6)="000000000000000000000") THEN count <= "10101";
	ELSIF (word(26 DOWNTO 7)="00000000000000000000") THEN count <= "10100";
	ELSIF (word(26 DOWNTO 8)="0000000000000000000") THEN count <= "10011";
	ELSIF (word(26 DOWNTO 9)="000000000000000000") THEN count <= "10010";
	ELSIF (word(26 DOWNTO 10)="00000000000000000") THEN count <= "10001";
	ELSIF (word(26 DOWNTO 11)="0000000000000000") THEN count <= "10000";
	ELSIF (word(26 DOWNTO 12)="000000000000000") THEN count <= "01111";
	ELSIF (word(26 DOWNTO 13)="00000000000000") THEN count <= "01110";
	ELSIF (word(26 DOWNTO 14)="0000000000000") THEN count <= "01101";
	ELSIF (word(26 DOWNTO 15)="000000000000") THEN count <= "01100";
	ELSIF (word(26 DOWNTO 16)="00000000000") THEN count <= "01011";
	ELSIF (word(26 DOWNTO 17)="0000000000") THEN count <= "01010";
	ELSIF (word(26 DOWNTO 18)="000000000") THEN count <= "01001";
	ELSIF (word(26 DOWNTO 19)="00000000") THEN count <= "01000";
	ELSIF (word(26 DOWNTO 20)="0000000") THEN count <= "00111";
	ELSIF (word(26 DOWNTO 21)="000000") THEN count <= "00110";
	ELSIF (word(26 DOWNTO 22)="00000") THEN count <= "00101";
	ELSIF (word(26 DOWNTO 23)="0000") THEN count <= "00100";
	ELSIF (word(26 DOWNTO 24)="000") THEN count <= "00011";
	ELSIF (word(26 DOWNTO 25)="00") THEN count <= "00010";
	ELSIF (word(26)='0') THEN count <= "00001";
	ELSE
		count <= "00000";
	END IF;
END PROCESS;

END FPlzc;
