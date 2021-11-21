library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.Numeric_Std.all;
use WORK.constants.all;
use WORK.my_data_types.all; 

ENTITY processing_unit IS
	GENERIC (Nbit : INTEGER := Numbit;
			 s    : INTEGER := shift;
			 N    : INTEGER := Nt);
	PORT (
		input_data   		: in  matrix (N downto 0);
		coefficient 	 	: in  matrix (N downto 0);
		clk, en, Rst_n 		: in  std_logic;
		out_en 		 		: out std_logic;
		result       		: out std_logic_vector (Nbit-1 downto 0));
END processing_unit; 

ARCHITECTURE structuer OF processing_unit IS 
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
	
	COMPONENT FlipFlop IS
   		PORT
   		(
      		d : 				IN  STD_LOGIC; 
	  		clk, clr : 			IN  STD_LOGIC;
      		Q : 				OUT STD_LOGIC
		);
	END COMPONENT;

	type matrix_mul_sign is array (natural range <>) of signed (2*(Nbit-s)-1 downto 0);
	type matrix_mul_std is array (natural range <>) of std_logic_vector (2*(Nbit-s)-1 downto 0);		
	signal mult_delayed_1cc								 : matrix_mul_std (N downto 0);
	signal mult_delayed_2cc 				 			 : matrix_mul_std (N downto N/2+1); 
	signal mult_new 					 				 : matrix_mul_sign (N downto 0);	
	signal result_1_stage   	 						 : signed (Nbit-s downto 0);
	signal result_1_stage_delayed_1cc					 : std_logic_vector (Nbit-s downto 0);
	signal result_2_stage  	 	 						 : signed (Nbit-s downto 0);
	signal en_delayed_1cc								 : std_logic;

	BEGIN
	gen_mult : for i in 0 to N GENERATE 
		mult_new(i) <= signed(input_data(i))*signed(coefficient(i));
	END GENERATE;

	-- generate 1 stage pipeline

 	reg_gen_stage_1 : for i in 0 to N GENERATE
		REGi_1_stage : reg
			GENERIC MAP ( Nb_reg => 2*(Nbit-s))
			PORT MAP ( d => std_logic_vector(mult_new(i)), clk => clk, en => en, clr => Rst_n, Q => mult_delayed_1cc(i));
	END GENERATE;

	result_1_stage <= signed(mult_delayed_1cc(0)(2*(Nbit-s)-1 downto (Nbit-s-1))) + 
					  signed(mult_delayed_1cc(1)(2*(Nbit-s)-1 downto (Nbit-s-1))) +
					  signed(mult_delayed_1cc(2)(2*(Nbit-s)-1 downto (Nbit-s-1))) + 
					  signed(mult_delayed_1cc(3)(2*(Nbit-s)-1 downto (Nbit-s-1))) +
					  signed(mult_delayed_1cc(4)(2*(Nbit-s)-1 downto (Nbit-s-1)));
	
	REG_1_STAGE : reg 
			GENERIC MAP ( Nb_reg => Nbit-s+1 )
			PORT MAP ( d => std_logic_vector(result_1_stage), clk => clk, en => en_delayed_1cc, clr => Rst_n, Q => result_1_stage_delayed_1cc);

	-- generate 2 stage pipeline

 	reg_gen_stage_2 : for i in N/2+1 to N GENERATE
		REGi_2_stage : reg
			GENERIC MAP ( Nb_reg => 2*(Nbit-s))
			PORT MAP ( d => mult_delayed_1cc(i), clk => clk, en => en_delayed_1cc, clr => Rst_n, Q => mult_delayed_2cc(i));
	END GENERATE;

	result_2_stage <= signed(result_1_stage_delayed_1cc) + 
					  signed(mult_delayed_2cc(5)(2*(Nbit-s)-1 downto (Nbit-s-1))) +
					  signed(mult_delayed_2cc(6)(2*(Nbit-s)-1 downto (Nbit-s-1))) +
					  signed(mult_delayed_2cc(7)(2*(Nbit-s)-1 downto (Nbit-s-1))) + 
					  signed(mult_delayed_2cc(8)(2*(Nbit-s)-1 downto (Nbit-s-1)));

	result <= std_logic_vector(result_2_stage)&(s-2 downto 0 => '0');
	
	-- Vout shift FFs 
	REG0_Vout : FlipFlop
		PORT MAP ( d => en , clk => clk, clr => Rst_n, Q => en_delayed_1cc);
	
	REG1_Vout : FlipFlop
		PORT MAP ( d => en_delayed_1cc , clk => clk, clr => Rst_n, Q => out_en);

END ARCHITECTURE;

	

