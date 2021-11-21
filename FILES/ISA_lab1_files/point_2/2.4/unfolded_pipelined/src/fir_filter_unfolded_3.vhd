library IEEE;
library work;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use WORK.constants.all;
use WORK.my_data_types.all; 

entity fir_filter_unfolded_3 is 
	generic (Nb : INTEGER := Numbit;
			 N  : INTEGER := Nt;
			 s 	: INTEGER := shift; 
			 k  : INTEGER := unfolding_stages);
	port (
    	Din_1 : 				in  STD_LOGIC_VECTOR (Nb-1 downto 0);
		Din_2 : 				in  STD_LOGIC_VECTOR (Nb-1 downto 0);
    	Din_3 : 				in  STD_LOGIC_VECTOR (Nb-1 downto 0);
		Vin   : 				in  std_logic_vector (k-1 downto 0);
		Rst_n, Ck : 			in  std_logic;
		b0 :					in  std_logic_vector (Nb-1 downto 0);			-- created array of N elements, each with Nbits
        b1 :					in  std_logic_vector (Nb-1 downto 0);
        b2 :					in  std_logic_vector (Nb-1 downto 0);
        b3 :					in  std_logic_vector (Nb-1 downto 0);
        b4 :					in  std_logic_vector (Nb-1 downto 0); 			
		Vout : 					out std_logic_vector (k-1 downto 0);	
		Dout_1 : 				out STD_LOGIC_VECTOR (Nb-1 downto 0);
		Dout_2 : 				out STD_LOGIC_VECTOR (Nb-1 downto 0);
		Dout_3 : 				out STD_LOGIC_VECTOR (Nb-1 downto 0));
end fir_filter_unfolded_3;

ARCHITECTURE structural OF fir_filter_unfolded_3 IS
	--components declaration	
	COMPONENT reg IS 
   		GENERIC (Nb_reg : INTEGER );
   		PORT
   		(
      		d : 				IN  STD_LOGIC_VECTOR (Nb_reg-1 downto 0); 
	  		clk, en, clr : 		IN  STD_LOGIC;
      		Q : 				OUT STD_LOGIC_vector (Nb_reg-1 downto 0)
   		);
	END COMPONENT;

	COMPONENT processing_unit IS 
		GENERIC (Nbit : INTEGER := Numbit;
				 N    : INTEGER := Nt;
				 s    : INTEGER := shift);
		PORT (
			input_data   	 : in  matrix  (N downto 0);
			coefficient  	 : in  matrix  (N downto 0);
			clk, en, Rst_n 	 : in  std_logic;
			out_en 		 	 : out std_logic;
			result       	 : out STD_LOGIC_VECTOR (Nb-1 downto 0));
	END COMPONENT; 
	
	--signals declaration 
	signal b          									: matrix_input (N downto 0);
	signal Din_pu1,Din_pu2,Din_pu3     					: matrix (N downto 0);	
	signal coefficient 									: matrix (N downto 0);
	signal Din_1_shift_1,Din_1_shift_2 					: std_logic_vector (Nb-1-s downto 0);  
	signal Din_2_shift_1,Din_2_shift_2,Din_2_shift_3  	: std_logic_vector (Nb-1-s downto 0);  
	signal Din_3_shift_1,Din_3_shift_2,Din_3_shift_3  	: std_logic_vector (Nb-1-s downto 0);  
	
	BEGIN 
	-- generated the shift regs for Din_1  
 		REG0_Din_1 : reg
			GENERIC MAP(Nb-s)
			PORT MAP ( d => Din_1(Nb-1 downto s), clk=> Ck, en => Vin(0), clr => Rst_n, Q => Din_1_shift_1);
		REG1_Din_1 : reg
			GENERIC MAP(Nb-s)
			PORT MAP ( d => Din_1_shift_1, clk=> Ck, en => Vin(0), clr => Rst_n, Q => Din_1_shift_2);
	-- generated the shift regs for Din_2
		REG0_Din_2 : reg
			GENERIC MAP(Nb-s)
			PORT MAP ( d => Din_2(Nb-1 downto s), clk=> Ck, en => Vin(1), clr => Rst_n, Q => Din_2_shift_1);
		REG1_Din_2 : reg
			GENERIC MAP(Nb-s)
			PORT MAP ( d => Din_2_shift_1, clk=> Ck, en => Vin(1), clr => Rst_n, Q => Din_2_shift_2);
		REG2_Din_2 : reg
			GENERIC MAP(Nb-s)
			PORT MAP ( d => Din_2_shift_2, clk=> Ck, en => Vin(1), clr => Rst_n, Q => Din_2_shift_3);
	-- generated the shift regs for Din_3
		REG0_Din_3 : reg
			GENERIC MAP(Nb-s)
			PORT MAP ( d => Din_3(Nb-1 downto s), clk=> Ck, en => Vin(2), clr => Rst_n, Q => Din_3_shift_1);
		REG1_Din_3 : reg
			GENERIC MAP(Nb-s)
			PORT MAP ( d => Din_3_shift_1, clk=> Ck, en => Vin(2), clr => Rst_n, Q => Din_3_shift_2);
		REG2_Din_3 : reg
			GENERIC MAP(Nb-s)
			PORT MAP ( d => Din_3_shift_2, clk=> Ck, en => Vin(2), clr => Rst_n, Q => Din_3_shift_3);

	--generated the inputs to processing unit 1
		Din_pu1(0) <= Din_1(Nb-1 downto s);
		Din_pu1(1) <= Din_3_shift_1;
		Din_pu1(2) <= Din_2_shift_1;
		Din_pu1(3) <= Din_1_shift_1;
		Din_pu1(4) <= Din_3_shift_2;
		Din_pu1(5) <= Din_2_shift_2;
		Din_pu1(6) <= Din_1_shift_2;
		Din_pu1(7) <= Din_3_shift_3;
		Din_pu1(8) <= Din_2_shift_3;
	--generated the inputs to processing unit 2
		Din_pu2(0) <= Din_2(Nb-1 downto s);
		Din_pu2(1) <= Din_1(Nb-1 downto s);
		Din_pu2(2) <= Din_3_shift_1;
		Din_pu2(3) <= Din_2_shift_1;
		Din_pu2(4) <= Din_1_shift_1;
		Din_pu2(5) <= Din_3_shift_2;
		Din_pu2(6) <= Din_2_shift_2;
		Din_pu2(7) <= Din_1_shift_2;
		Din_pu2(8) <= Din_3_shift_3;	
	--generated the inputs to processing unit 3
		Din_pu3(0) <= Din_3(Nb-1 downto s);
		Din_pu3(1) <= Din_2(Nb-1 downto s);
		Din_pu3(2) <= Din_1 (Nb-1 downto s);
		Din_pu3(3) <= Din_3_shift_1;
		Din_pu3(4) <= Din_2_shift_1;
		Din_pu3(5) <= Din_1_shift_1;
		Din_pu3(6) <= Din_3_shift_2;
		Din_pu3(7) <= Din_2_shift_2;
		Din_pu3(8) <= Din_1_shift_2;		

	--generated the matrix of coefficients
		b(0) <= b0;
        b(8) <= b0;
	    b(1) <= b1;
		b(7) <= b1;
		b(2) <= b2;
        b(6) <= b2;
        b(3) <= b3;
		b(5) <= b3;
		b(4) <= b4;	
		
		gen_shifted_coef : for i in 0 to N generate 
			coefficient(i)(Nb-1-s downto 0)<= b(i)(Nb-1 downto s);
		end generate;
				
	--generated the processing units 
	proc_unit_1 : processing_unit 
		PORT MAP ( Din_pu1, coefficient , Ck, Vin(0), Rst_n, Vout(0), Dout_1);
	proc_unit_2 : processing_unit 
		PORT MAP ( Din_pu2, coefficient , Ck, Vin(1), Rst_n, Vout(1), Dout_2);
	proc_unit_3 : processing_unit 
		PORT MAP ( Din_pu3, coefficient , Ck, Vin(2), Rst_n, Vout(2), Dout_3);


END ARCHITECTURE; 
			
	
	
