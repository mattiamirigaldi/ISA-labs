LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
 
entity FPmul_tb is 
end FPmul_tb;

architecture bhv of FPmul_tb is

component FPmul IS
   PORT( 
      FP_A : IN     std_logic_vector (31 DOWNTO 0);
      FP_B : IN     std_logic_vector (31 DOWNTO 0);
      clk  : IN     std_logic;
      FP_Z : OUT    std_logic_vector (31 DOWNTO 0)
   );
END component ;

component data_maker is
  port (
    CLK  : in  std_logic;
    DATA : out std_logic_vector(31 downto 0));
end component;



--signal declaration
signal		FP_A_tb : 				 STD_LOGIC_VECTOR (31 downto 0);
signal		FP_B_tb : 				 STD_LOGIC_VECTOR (31 downto 0);
signal		FP_Z_tb : 				 STD_LOGIC_VECTOR (31 downto 0);
signal		in_FP : 				 STD_LOGIC_VECTOR (31 downto 0);
signal		CLK_i : 				 STD_LOGIC;
begin 
FP_A_tb<= in_FP;
FP_B_tb<= in_FP;

mul: FPmul
PORT MAP(FP_A_tb, FP_B_tb ,CLK_i, FP_Z_tb);

input_data: data_maker
PORT MAP(clk_i, in_FP);

 

CLK : PROCESS
	begin
     if (CLK_i = 'U') then
    CLK_i <= '0';
  else 
    CLK_i <= not(CLK_i);
  end if;
  wait for 5 ns;
	end process;

end bhv;
