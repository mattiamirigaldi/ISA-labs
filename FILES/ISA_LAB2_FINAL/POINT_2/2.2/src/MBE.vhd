library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all;
use IEEE.numeric_std.all;
use WORK.constants.all; 

ENTITY MBE  IS 
	GENERIC ( NBIT_A : integer := NumBit_A;
				 NBIT_B : integer := NumBit_B;
				 NBIT_P : integer := NumBit_P
				);
	
	PORT ( A 	: IN  std_logic_vector ( NBIT_A-1 downto 0);
	       X		: IN  std_logic_vector ( NBIT_B-1 downto 0);
			 res    : OUT std_logic_vector ( NBIT_P-1 downto 0)
		   );
end MBE ;
			 
			 
ARCHITECTURE STRUCTURAL OF MBE IS 

--components declaration 
component dadda IS 
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
	end component;
	
	
	COMPONENT Booth_Encoder IS 
		GENERIC ( NBIT_A : integer := NumBit_A); --24 bits
		PORT( A 				: IN 	STD_LOGIC_VECTOR (NBIT_A DOWNTO 0);
				A2_pos		:IN 	STD_LOGIC_VECTOR (NBIT_A DOWNTO 0);
				X  			: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
				sign			:OUT STD_LOGIC;
				partial_prod: OUT STD_LOGIC_VECTOR (NBIT_A DOWNTO 0));
	END COMPONENT; 

--signals declaration
subtype row_numb is natural range 0 to NBIT_A/2; -- using natural type
type row_ARRAY is array(row_numb) of  std_logic_vector(NBIT_A downto 0);
signal row : row_ARRAY; --MATRICE

signal sign: std_logic_vector(NBIT_A/2 downto 0):=(others=>'0');
signal out_dadda_0: std_logic_vector(NBIT_P-1 downto 0):=(others=>'0');
signal sum,out_dadda_1: std_logic_vector(NBIT_P-2 downto 0):=(others=>'0');
signal A_extended,A_shifted_by2: std_logic_vector(NBIT_A downto 0):=(others=>'0');
signal X_tmp: std_logic_vector(NBIT_B+2 downto 0):=(others=>'0');


BEGIN
A_extended<=std_logic_vector(resize(unsigned(A), A_extended'length));	--'0'&A;
A_shifted_by2<=std_logic_vector(shift_left(unsigned(A_extended),1));	--A_extended(NBIT_A-1 DOWNTO 0) & '0';
X_tmp<="00"& X & '0';

--Partial_prods:
Booth_Encoder_1_13: for i in 0 to 12 generate
Booth_Encoder_i : Booth_Encoder PORT MAP(A_extended, A_shifted_by2, X_tmp((2*i)+2 downto 2*i), sign(i), row(i));
end generate Booth_Encoder_1_13;

--Dadda tree:
Dadda_OP:
Dadda PORT MAP(sign(11 downto 0), row(0),row(1), row(2), row(3), row(4), row(5), row(6), row(7), row(8), row(9), row(10), row(11), row(12)(NBIT_A-1 downto 0), out_dadda_0, out_dadda_1);
sum<= std_logic_vector(unsigned(out_dadda_0 (47 downto 1))+ unsigned(out_dadda_1));
res<=sum & out_dadda_0(0);

END ARCHITECTURE;
