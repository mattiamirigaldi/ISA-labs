library IEEE;
use IEEE.STD_LOGIC_1164.all;
use WORK.constants.all; 

ENTITY Booth_Encoder IS 
		GENERIC ( NBIT_A : integer := NumBit_A); --24 bits
		PORT(	A 				: IN 	STD_LOGIC_VECTOR (NBIT_A DOWNTO 0);
				A2_pos			: IN 	STD_LOGIC_VECTOR (NBIT_A DOWNTO 0);
				X  				: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
				sign			: OUT STD_LOGIC;
				partial_prod	: OUT STD_LOGIC_VECTOR (NBIT_A DOWNTO 0));
END Booth_Encoder; 

ARCHITECTURE Behavior OF Booth_Encoder IS 
BEGIN 
	PROCESS(X, A, A2_pos)  -- since the sensitivity list contain all the inputs of the component, the component is purely combinational
	BEGIN 
		CASE X IS 
			WHEN "000" => partial_prod <= (others=>'0');  	-- out of the MUX = 0
			WHEN "001" => partial_prod <= A;						-- out of the MUX = A
			WHEN "010" => partial_prod <= A;						-- out of the MUX = A
			WHEN "011" => partial_prod <= A2_pos;				-- out of the MUX = 2A
			WHEN "100" => partial_prod <= not(A2_pos);			-- out of the MUX = -2A
			WHEN "101" => partial_prod <= not(A);				-- out of the MUX = -A
			WHEN "110" => partial_prod <= not(A);				-- out of the MUX = -A
			WHEN "111" => partial_prod <= (others=>'1');		-- out of the MUX = 0 o 1???
			WHEN Others => partial_prod <= (others=>'0');
		end case;
	end process;
	sign<=X(2);
end Behavior;
