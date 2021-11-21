library IEEE;
library work;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use WORK.constants.all;
use WORK.my_data_types.all; 


entity fir_filter is
	generic (Nb : INTEGER := Numbit;
			 N  : INTEGER := Nt;
			 s  : INTEGER := shift);
  	port (
    	Din : 				in  STD_LOGIC_VECTOR (Nb-1 downto 0);
    	Vin, Rst_n, Ck : 	in  std_logic;
		b0 :				in  std_logic_vector 	 (Nb-1 downto 0);			-- created array of N elements, each with Nbits
        b1 :				in  std_logic_vector 	 (Nb-1 downto 0);
        b2 :				in  std_logic_vector 	 (Nb-1 downto 0);
        b3 :				in  std_logic_vector 	 (Nb-1 downto 0);
        b4 :				in  std_logic_vector 	 (Nb-1 downto 0); 
		Vout : 				out std_logic;    	
		Dout : 				out STD_LOGIC_VECTOR (Nb-1 downto 0));
end fir_filter;

architecture structural of fir_filter is 

	COMPONENT reg IS 
   		GENERIC (Nb : INTEGER := Numbit;
		      	 s  : INTEGER := shift);
   		PORT
   		(
      		d : 				IN  STD_LOGIC_VECTOR (Nb-1-s downto 0); 
	  		clk, en, clr : 		IN  STD_LOGIC;
      		Q : 				OUT STD_LOGIC_vector (Nb-1-s downto 0)
   		);
	END COMPONENT;

	COMPONENT processing_unit IS 
		GENERIC (Nb : INTEGER := Numbit;
				 N  : INTEGER := Nt;
				 s  : INTEGER := shift);
		PORT (
			input_data   : in  matrix  (N downto 0);
			coefficient  : in  matrix  (N downto 0);
			clk, en 	 : in  std_logic;
			out_en 		 : out std_logic;
			result       : out STD_LOGIC_VECTOR (Nb-1 downto 0));
	END COMPONENT; 
    signal  b          : matrix_input (N downto 0);
	signal 	Din_reg    : matrix (N downto 0);	
	signal coefficient : matrix (N downto 0);
--	constant N : integer := Nt;

	BEGIN
	-- generate the shift regs  
 		reg_gen : for i in 0 to N GENERATE
				First_reg : if i = 0 generate
					REG0 : reg
						PORT MAP ( d => Din (Nb-1 downto s), clk=> Ck, en => Vin, clr => Rst_n, Q => Din_reg(0)(Nb-1-s downto 0) );
					end generate;	
				 Other_reg : if i > 0 generate
					REGi : reg
						PORT MAP ( d => Din_reg(i-1), clk => Ck, en => Vin, clr => Rst_n, Q => Din_reg(i)(Nb-1-s downto 0));
				    end generate;
		 END GENERATE;
   
        b(0) <= b0;
        b(8) <= b0;
	    b(1) <= b1;
		b(7) <= b1;
		b(2) <= b2;
        b(6) <= b2;
        b(3) <= b3;
		b(5) <= b3;
		b(4) <= b4;
	
		-- generate the shifted coefficients
		gen_shifted_coef : for i in 0 to N generate 
			coefficient(i)(Nb-1-s downto 0)<= b(i)(Nb-1 downto s);
		end generate;	
		
		-- generate the processing unit
		proc_unit : processing_unit 
		PORT MAP ( Din_reg (N downto 0), coefficient  , Ck, Vin, Vout, Dout);

END architecture;
