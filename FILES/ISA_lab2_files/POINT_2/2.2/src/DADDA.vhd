library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all;
use IEEE.numeric_std.all;
use WORK.constants.all; 

ENTITY dadda IS 
	GENERIC ( NBIT_A : integer := NumBit_A); --24 bits
		PORT (
	signs: in std_logic_vector(NBIT_A/2-1 downto 0);
	--PARTIAL PRODUCTS: INPUTS  OF 25 bit
	row1, row2,	row3,	row4, row5, row6, row7, row8, row9, row10, row11, row12: in std_logic_vector(NBIT_A downto 0); 
	row13: in std_logic_vector(NBIT_A-1 downto 0); --24 bit input
	--OUTPUTS
	out_row0: out std_logic_vector(NBIT_A*2-1 downto 0); --48 bit out
	out_row1: out std_logic_vector(NBIT_A*2-2 downto 0) --47 bit out
   );
end dadda;			 
ARCHITECTURE STRUCTURAL OF dadda IS	
---------------COMPONENT DECLARATION----------------------------
--FA
component FA is 
	Port (	A:	In	std_logic;
		B:	In	std_logic;
		Ci:	In	std_logic;
		S:	Out	std_logic;
		Co:	Out	std_logic);
end component;
--HA
component HA is 
	Port (	A:	In	std_logic;
		B:	In	std_logic;
		S:	Out	std_logic;
		Co:	Out	std_logic);
end component;
---------------SIGNAL DECLARATION--------------------------------------
--stage of 13  rows
	signal r0_s13: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
signal r1_s13: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
signal r2_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
signal r3_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r4_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r5_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r6_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r7_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r8_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r9_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r10_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r11_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r12_s13: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	 
	--stage of 9 rows
	signal r0_s9: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r1_s9: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r2_s9: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r3_s9: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r4_s9: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r5_s9: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r6_s9: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r7_s9: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 
	signal r8_s9: std_logic_vector(NBIT_A*2-1  downto 0):= (others=>'0'); 

	--stage of 6 rows
	signal r0_s6: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
	signal r1_s6: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
	signal r2_s6: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
	signal r3_s6: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
	signal r4_s6: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
	signal r5_s6: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 

--stage of 4 rows
	signal r0_s4: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
	signal r1_s4: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
	signal r2_s4: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
	signal r3_s4: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
--stage of 3 rows
	signal r0_s3: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
	signal r1_s3: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
	signal r2_s3: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 

--stage of 2 rows
	signal r0_s2: std_logic_vector(NBIT_A*2 downto 0):= (others=>'0'); 
	signal r1_s2: std_logic_vector(NBIT_A*2-1 downto 0):= (others=>'0'); 
BEGIN
------ STAGE 13: tree assignment
r1_s13(0)<=signs(0);
r2_s13(2)<=signs(1);
r3_s13(4)<=signs(2);
r4_s13(6)<=signs(3);
r5_s13(8)<=signs(4);
r6_s13(10)<=signs(5);
r7_s13(12)<=signs(6);
r8_s13(14)<=signs(7);
r9_s13(16)<=signs(8);
r10_s13(18)<=signs(9);
r11_s13(20)<=signs(10);
r12_s13(22)<=signs(11);
r0_s13(47 downto 0)<=(not(signs(11)) & '1' & not(signs(10)) & '1' & not(signs(9)) & '1' & not(signs(8)) & '1' & not(signs(7)) & '1' & not(signs(6)) & '1' & not(signs(5)) & '1' & not(signs(4)) & '1' & not(signs(3)) & '1' & not(signs(2)) & '1' & not(signs(0)) & signs(0) & signs(0) & row1); 
r1_s13(47 downto 2)<=( row13(23)& row12(24)& row12(23)&  row11(24)& row11(23)& row10(24)& row10(23)& row9(24)& row9(23)& row8(24)& row8(23)& row7(24)& row7(23)& row6(24)& row6(23)& row5(24)& row5(23)& row4(24)& row4(23)& row3(24)& not(signs(1)) & row2);
r2_s13(46 downto 4)<=(row13(22) & row13(21) & row12(22) & row12(21) & row11(22) & row11(21) & row10(22) & row10(21) & row9(22) & row9(21) & row8(22) & row8(21) & row7(22) & row7(21) & row6(22) & row6(21) & row5(22) & row5(21) & row4(22) & row3(23 downto 0));
r3_s13(44 downto 6)<=( row13(20)& row13(19) & row12(20)& row12(19)&  row11(20) & row11(19) & row10(20) & row10(19) & row9(20) & row9(19) & row8(20) & row8(19) & row7(20) & row7(19) & row6(20) & row6(19) & row5(20) & row4(21 downto 0));
r4_s13(42 downto 8)<=( row13(18)& row13(17) & row12(18)& row12(17)&  row11(18) & row11(17) & row10(18) & row10(17) & row9(18) & row9(17) & row8(18) & row8(17) & row7(18) & row7(17) & row6(18) & row5(19 downto 0));
r5_s13(40 downto 10)<=( row13(16)& row13(15) & row12(16)& row12(15)& row11(16) & row11(15) & row10(16) & row10(15) & row9(16) & row9(15) & row8(16) & row8(15) & row7(16) & row6(17 downto 0));
r6_s13(38 downto 12)<=( row13(14)& row13(13) & row12(14)& row12(13)& row11(14) & row11(13) & row10(14) & row10(13) & row9(14) & row9(13) & row8(14) & row7(15 downto 0));
r7_s13(36 downto 14)<=( row13(12) & row13(11) & row12(12)& row12(11)& row11(12) & row11(11) & row10(12) & row10(11) & row9(12) & row8(13 downto 0));
r8_s13(34 downto 16)<=( row13(10) & row13(9) & row12(10)& row12(9)&  row11(10) & row11(9) & row10(10) & row9(11 downto 0));
r9_s13(32 downto 18)<=( row13(8) & row13(7) & row12(8)& row12(7)& row11(8) & row10(9 downto 0));
r10_s13(30 downto 20)<=( row13(6) & row13(5) & row12(6)& row11(7 downto 0));
r11_s13(28 downto 22)<=( row13(4) & row12(5 downto 0));
r12_s13(27 downto 24)<=row13(3 downto 0);

-----ADDERS assignment
--ha column 16-23,28, 30,32,34
HA_s13_16: HA PORT MAP ( r0_s13(16), r1_s13(16), r0_s9(16),r0_s9(17));  
HA_s13_17: HA PORT MAP ( r0_s13(17), r1_s13(17), r1_s9(17),r0_s9(18));
HA_s13_18: HA PORT MAP ( r3_s13(18), r4_s13(18), r2_s9(18),r1_s9(19)); 
HA_s13_19: HA PORT MAP ( r3_s13(19), r4_s13(19), r3_s9(19),r1_s9(20)); 
HA_s13_20: HA PORT MAP ( r6_s13(20), r7_s13(20), r4_s9(20),r2_s9(21));
HA_s13_21: HA PORT MAP ( r6_s13(21), r7_s13(21), r5_s9(21),r2_s9(22));
HA_s13_22: HA PORT MAP ( r9_s13(22), r10_s13(22), r6_s9(22),r3_s9(23));
HA_s13_23: HA PORT MAP ( r9_s13(23), r10_s13(23), r7_s9(23),r3_s9(24));
HA_s13_28: HA PORT MAP ( r9_s13(28), r10_s13(28), r7_s9(28),r3_s9(29));
HA_s13_30: HA PORT MAP ( r6_s13(30), r7_s13(30), r5_s9(30),r2_s9(31));
HA_s13_32: HA PORT MAP ( r3_s13(32), r4_s13(32), r3_s9(32),r1_s9(33));
HA_s13_34: HA PORT MAP ( r0_s13(34), r1_s13(34), r1_s9(34),r0_s9(35));
 
--fa column 18-33 FIRST ROW OF FA
 
FA_s13_18: FA PORT MAP ( r0_s13(18), r1_s13(18), r2_s13(18), r1_s9(18),r0_s9(19));

FA_S13_19: for i in 19 to 20 generate
FA_19_20: FA PORT MAP ( r0_s13(i), r1_s13(i), r2_s13(i), r2_s9(i),r0_s9(i+1));
end generate FA_S13_19;
 
FA_S13_21: for i in 21 to 22 generate
FA_21_24: FA PORT MAP ( r0_s13(i), r1_s13(i), r2_s13(i), r3_s9(i),r0_s9(i+1));
end generate FA_S13_21;
 
FA_S13_23: for i in 23 to 29 generate
FA_23_29: FA PORT MAP ( r0_s13(i), r1_s13(i), r2_s13(i), r4_s9(i),r0_s9(i+1));
end generate FA_S13_23;
 
FA_S13_30: for i in 30 to 31 generate
FA_30_31: FA PORT MAP ( r0_s13(i), r1_s13(i), r2_s13(i), r3_s9(i),r0_s9(i+1));
end generate FA_S13_30;
 
FA_S13_32: for i in 32 to 33 generate
FA_32_33: FA PORT MAP ( r0_s13(i), r1_s13(i), r2_s13(i), r2_s9(i),r0_s9(i+1));
end generate FA_S13_32;
 
--fa column 20-31 SECOND ROW OF FA
FA_s13_20: FA PORT MAP ( r3_s13(20), r4_s13(20), r5_s13(20), r3_s9(20),r1_s9(21));
 
FA_S13_21_row2: for i in 21 to 22 generate
FA_22_21_row2: FA PORT MAP ( r3_s13(i), r4_s13(i), r5_s13(i), r4_s9(i),r1_s9(i+1));
end generate FA_S13_21_row2;
 
FA_S13_23_row2: for i in 23 to 29 generate
FA_23_29_row2: FA PORT MAP ( r3_s13(i), r4_s13(i), r5_s13(i), r5_s9(i),r1_s9(i+1));
end generate FA_S13_23_row2;
 
FA_S13_30_row2: for i in 30 to 31 generate
FA_30_31_row2: FA PORT MAP ( r3_s13(i), r4_s13(i), r5_s13(i), r4_s9(i),r1_s9(i+1));
end generate FA_S13_30_row2;
 
--fa column 22-29 THIRD ROW OF FA
FA_S13_22: FA PORT MAP ( r6_s13(22), r7_s13(22), r8_s13(22), r5_s9(22),r2_s9(23));
 
FA_S13_23_29: for i in 23 to 29 generate
FA_23_29: FA PORT MAP ( r6_s13(i), r7_s13(i), r8_s13(i), r6_s9(i),r2_s9(i+1));
end generate FA_S13_23_29;
 
-- fa column 24-27 FORTH ROW
FA_S13_24_27: for i in 24 to 27 generate
FA_s13_24_row4: FA PORT MAP ( r9_s13(i), r10_s13(i), r11_s13(i), r7_s9(i),r3_s9(i+1));
end generate FA_S13_24_27;

----POINTS assignment
r0_s9(15 downto 0)<=r0_s13(15 downto 0);
r1_s9(15 downto 0)<=r1_s13(15 downto 0);
r2_s9(15 downto 2)<=r2_s13(15 downto 2);
r3_s9(15 downto 4)<=r3_s13(15 downto 4);
r4_s9(15 downto 6)<=r4_s13(15 downto 6);
r5_s9(15 downto 8)<=r5_s13(15 downto 8);
r6_s9(15 downto 10)<=r6_s13(15 downto 10);
r7_s9(15 downto 12)<=r7_s13(15 downto 12);
r8_s9(14)<=r8_s13(14);
--16
r1_s9(16)<=r2_s13(16);
r2_s9(16)<=r3_s13(16);
r3_s9(16)<=r4_s13(16);
r4_s9(16)<=r5_s13(16);
r5_s9(16)<=r6_s13(16);
r6_s9(16)<=r7_s13(16);
r7_s9(16)<=r8_s13(16);
r8_s9(16)<=r9_s13(16);
--17
r2_s9(17)<=r2_s13(17);
r3_s9(17)<=r3_s13(17);
r4_s9(17)<=r4_s13(17);
r5_s9(17)<=r5_s13(17);
r6_s9(17)<=r6_s13(17);
r7_s9(17)<=r7_s13(17);
r8_s9(17)<=r8_s13(17);
--18
r3_s9(18)<=r5_s13(18);
r4_s9(18)<=r6_s13(18);
r5_s9(18)<=r7_s13(18);
r6_s9(18)<=r8_s13(18);
r7_s9(18)<=r9_s13(18);
r8_s9(18)<=r10_s13(18);

--19
r4_s9(19)<=r5_s13(19);
r5_s9(19)<=r6_s13(19);
r6_s9(19)<=r7_s13(19);
r7_s9(19)<=r8_s13(19);
r8_s9(19)<=r9_s13(19);
--20
r5_s9(20)<=r8_s13(20);
r6_s9(20)<=r9_s13(20);
r7_s9(20)<=r10_s13(20);
r8_s9(20)<=r11_s13(20);

r6_s9(21)<=r8_s13(21);
r7_s9(21)<=r9_s13(21);
r8_s9(21)<=r10_s13(21);

r7_s9(22)<=r11_s13(22);
r8_s9(22)<=r12_s13(22);
r8_s9(23)<=r11_s13(23);
r8_s9(27 downto 24)<=r12_s13(27 downto 24);
r8_s9(28)<=r11_s13(28);
r8_s9(30 downto 29)<=r10_s13(30 downto 29);
r7_s9(30 downto 29)<=r9_s13(30 downto 29);
r6_s9(30)<=r8_s13(30);
r5_s9(32 downto 31)<= r6_s13(32 downto 31);
r6_s9(32 downto 31)<= r7_s13(32 downto 31);
r7_s9(32 downto 31)<= r8_s13(32 downto 31);
r8_s9(32 downto 31)<= r9_s13(32 downto 31);
r4_s9(32)<=r5_s13(32);
r3_s9(34 downto 33)<=r3_s13(34 downto 33);
r4_s9(34 downto 33)<=r4_s13(34 downto 33);
r5_s9(34 downto 33)<=r5_s13(34 downto 33);
r6_s9(34 downto 33)<=r6_s13(34 downto 33);
r7_s9(34 downto 33)<=r7_s13(34 downto 33);
r8_s9(34 downto 33)<=r8_s13(34 downto 33);
r2_s9(34)<=r2_s13(34);
r1_s9(35)<=r0_s13(35);
r2_s9(35)<=r1_s13(35);
r3_s9(35)<=r2_s13(35);
r4_s9(35)<=r3_s13(35);
r5_s9(35)<=r4_s13(35);
r6_s9(35)<=r5_s13(35);
r7_s9(35)<=r6_s13(35);
r8_s9(35)<=r7_s13(35);
r7_s9(36)<=r7_s13(36);
r0_s9(47 downto 36)<=r0_s13(47 downto 36);
r1_s9(47 downto 36)<=r1_s13(47 downto 36);
r2_s9(46 downto 36)<=r2_s13(46 downto 36);
r3_s9(44 downto 36)<=r3_s13(44 downto 36);
r4_s9(42 downto 36)<=r4_s13(42 downto 36);
r5_s9(40 downto 36)<=r5_s13(40 downto 36);
r6_s9(38 downto 36)<=r6_s13(38 downto 36);


------- STAGE 9
-----ADDERS assignment
--ha column 10-15, 35,37,39
HA_s9_10: HA PORT MAP ( r0_s9(10), r1_s9(10), r0_s6(10),r0_s6(11)); 
HA_s9_11: HA PORT MAP ( r0_s9(11), r1_s9(11), r1_s6(11),r0_s6(12));
HA_s9_12: HA PORT MAP ( r3_s9(12), r4_s9(12), r2_s6(12),r1_s6(13));
HA_s9_13: HA PORT MAP ( r3_s9(13), r4_s9(13), r3_s6(13),r1_s6(14));
HA_s9_14: HA PORT MAP ( r6_s9(14), r7_s9(14), r4_s6(14),r2_s6(15));
HA_s9_15: HA PORT MAP ( r6_s9(15), r7_s9(15), r5_s6(15),r2_s6(16));
HA_s9_36: HA PORT MAP ( r6_s9(36), r7_s9(36), r5_s6(36),r2_s6(37));
HA_s9_38: HA PORT MAP ( r3_s9(38), r4_s9(38), r3_s6(38),r1_s6(39));
HA_s9_40: HA PORT MAP ( r0_s9(40), r1_s9(40), r1_s6(40),r0_s6(41));

--fa column 12-39 FIRST ROW OF FA
 
FA_s9_12: FA PORT MAP
( r0_s9(12), r1_s9(12), r2_s9(12), r1_s6(12),r0_s6(13));
 
FA_S9_13_14: for i in 13 to 14 generate
FA_13_14: FA PORT MAP ( r0_s9(i), r1_s9(i), r2_s9(i), r2_s6(i),r0_s6(i+1));
end generate FA_S9_13_14;
 
FA_S9_15: for i in 15 to 37 generate
FA_15_37: FA PORT MAP ( r0_s9(i), r1_s9(i), r2_s9(i), r3_s6(i),r0_s6(i+1));
end generate FA_S9_15;

FA_S9_38: for i in 38 to 39 generate
FA_38_39: FA PORT MAP ( r0_s9(i), r1_s9(i), r2_s9(i), r2_s6(i),r0_s6(i+1));
end generate FA_S9_38;

 
--fa column 14-37 SECOND ROW OF FA
FA_s9_14: FA PORT MAP ( r3_s9(14), r4_s9(14), r5_s9(14), r3_s6(14),r1_s6(15));
 
FA_S9_15_37: for i in 15 to 37 generate
FA_15_37: FA PORT MAP ( r3_s9(i), r4_s9(i), r5_s9(i), r4_s6(i),r1_s6(i+1));
end generate FA_S9_15_37;
 
--fa column 16-35 THIRD ROW OF FA
FA_S9_16: for i in 16 to 35 generate
FA_16_35: FA PORT MAP ( r6_s9(i), r7_s9(i), r8_s9(i), r5_s6(i),r2_s6(i+1));
end generate FA_S9_16;

----POINT assignments
r0_s6(9 downto 0)<=r0_s9(9 downto 0);
r1_s6(9 downto 0)<=r1_s9(9 downto 0);
r2_s6(9 downto 2)<=r2_s9(9 downto 2);
r3_s6(9 downto 4)<=r3_s9(9 downto 4);
r4_s6(9 downto 6)<=r4_s9(9 downto 6);
r5_s6(8)<=r5_s9(8);
r1_s6(10)<=r2_s9(10);
r2_s6(10)<=r3_s9(10);
r3_s6(10)<=r4_s9(10);
r4_s6(10)<=r5_s9(10);
r5_s6(10)<=r6_s9(10);
r2_s6(11)<=r2_s9(11);
r3_s6(11)<=r3_s9(11);
r4_s6(11)<=r4_s9(11);
r5_s6(11)<=r5_s9(11);

r3_s6(12)<=r5_s9(12);
r4_s6(12)<=r6_s9(12);
r5_s6(12)<=r7_s9(12);

r4_s6(13)<=r5_s9(13);
r5_s6(13)<=r6_s9(13);
r5_s6(14)<=r8_s9(14);
r5_s6(38 downto 37)<=r6_s9(38 downto 37);
r4_s6(38)<=r5_s9(38);

r5_s6(40 downto 39)<=r5_s9(40 downto 39);
r4_s6(40 downto 39)<=r4_s9(40 downto 39);
r3_s6(40 downto 39)<=r3_s9(40 downto 39);
r2_s6(40)<=r2_s9(40);
r1_s6(41)<=r0_s9(41);
r2_s6(41)<=r1_s9(41);
r3_s6(41)<=r2_s9(41);
r4_s6(41)<=r3_s9(41);
r5_s6(41)<=r4_s9(41);
r4_s6(42)<=r4_s9(42);
r0_s6(47 downto 42)<=r0_s9(47 downto 42);
r1_s6(47 downto 42)<=r1_s9(47 downto 42);
r2_s6(46 downto 42)<=r2_s9(46 downto 42);
r3_s6(44 downto 42)<=r3_s9(44 downto 42);


------- STAGE 6
-----ADDERS assignment
--ha column 6-9,42,44
HA_s6_6: HA PORT MAP ( r0_s6(6), r1_s6(6), r0_s4(6),r0_s4(7)); 
HA_s6_7: HA PORT MAP ( r0_s6(7), r1_s6(7), r1_s4(7),r0_s4(8));
HA_s6_8: HA PORT MAP ( r3_s6(8), r4_s6(8), r2_s4(8),r1_s4(9));
HA_s6_9: HA PORT MAP ( r3_s6(9), r4_s6(9), r3_s4(9),r1_s4(10));
HA_s6_42: HA PORT MAP ( r3_s6(42), r4_s6(42), r3_s4(42),r1_s4(43));
HA_s6_44: HA PORT MAP ( r0_s6(44), r1_s6(44), r1_s4(44),r0_s4(45));
 
--fa column 8-43 FIRST ROW OF FA
FA_s6_8: FA PORT MAP ( r0_s6(8), r1_s6(8), r2_s6(8), r1_s4(8),r0_s4(9));
 
FA_S6_9_43: for i in 9 to 43 generate
FA_9_43: FA PORT MAP ( r0_s6(i), r1_s6(i), r2_s6(i), r2_s4(i),r0_s4(i+1));
end generate FA_S6_9_43;
 
--fa column 10-41 SECOND ROW OF FA
FA_S6_10: for i in 10 to 41 generate
FA_10_41: FA PORT MAP ( r3_s6(i), r4_s6(i), r5_s6(i), r3_s4(i),r1_s4(i+1));
end generate FA_S6_10;
 

----POINT assignments
r0_s4(5 downto 0)<=r0_s6(5 downto 0);
r1_s4(5 downto 0)<=r1_s6(5 downto 0);
r2_s4(5 downto 2)<=r2_s6(5 downto 2);
r3_s4(4)<=r3_s6(4);
r1_s4(6)<=r2_s6(6);
r2_s4(6)<=r3_s6(6);
r3_s4(6)<=r4_s6(6);
r2_s4(7)<=r2_s6(7);
r3_s4(7)<=r3_s6(7);
r3_s4(8)<=r5_s6(8);
r3_s4(44 downto 43)<=r3_s6(44 downto 43);
r2_s4(44)<=r2_s6(44);
r1_s4(45)<=r0_s6(45);
r2_s4(45)<=r1_s6(45);
r3_s4(45)<=r2_s6(45);
r0_s4(47 downto 46)<=r0_s6(47 downto 46);
r1_s4(47 downto 46)<=r1_s6(47 downto 46);
r2_s4(46)<=r2_s6(46);

------- STAGE 4
-----ADDERS assignment
--ha column 4,5,46
HA_S4_4: HA PORT MAP ( r0_s4(4), r1_s4(4), r0_s3(4),r0_s3(5)); --4
HA_S4_5: HA PORT MAP ( r0_s4(5), r1_s4(5), r1_s3(5),r0_s3(6));--5
HA_S4_46: HA PORT MAP( r0_s4(46), r1_s4(46), r1_s3(46),r0_s3(47));

--fa column 6-45
FA_S4_6: for i in 6 to 45 generate
FA_6_45: FA PORT MAP ( r0_s4(i), r1_s4(i), r2_s4(i), r1_s3(i),r0_s3(i+1));
end generate FA_S4_6;

----POINT assignments
r0_s3(3 downto 0)<=r0_s4(3 downto 0);
r1_s3(3 downto 0)<=r1_s4(3 downto 0);
r2_s3(2)<=r2_s4(2);
r1_s3(4)<=r2_s4(4);
r2_s3(4)<=r3_s4(4);
r2_s3(5)<=r2_s4(5);
r2_s3(45 downto 6)<=r3_s4(45 downto 6);
r2_s3(46)<=r2_s4(46);
r1_s3(47)<=r0_s4(47);
r2_s3(47)<=r1_s4(47);


------- STAGE 3
-----ADDERS assignment
--ha column 0,2,3
HA_s3_0: HA PORT MAP ( r0_s3(0), r1_s3(0), r0_s2(0),r0_s2(1));
HA_S3_2: HA PORT MAP ( r0_s3(2), r1_s3(2), r0_s2(2),r0_s2(3)); 
HA_S3_3: HA PORT MAP ( r0_s3(3), r1_s3(3), r1_s2(3),r0_s2(4));
 
--fa column 4-46
FA_S3_4: for i in 4 to 47 generate
FA_4_47: FA PORT MAP ( r0_s3(i), r1_s3(i), r2_s3(i), r1_s2(i),r0_s2(i+1)); --check carry out of Column 47
end generate FA_S3_4;
----POINT assignments
r1_s2(1)<=r0_s3(1);
r1_s2(2)<=r2_s3(2);


------ STAGE 2: outputs
 out_row0<=r0_s2(47 downto 0);  --48 bits
 out_row1<=r1_s2(47 downto 1); --47 bits
END ARCHITECTURE;
