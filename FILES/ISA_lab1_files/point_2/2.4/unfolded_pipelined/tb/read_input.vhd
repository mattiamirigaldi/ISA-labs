library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity read_input is
  port(
    Clk    	 : in std_logic;
    Rst_n  	 : in std_logic;
    Vout   	 : out std_logic_vector(2 downto 0);
    Dout_1   : out std_logic_vector(13 downto 0);
	Dout_2   : out std_logic_vector(13 downto 0);
	Dout_3   : out std_logic_vector(13 downto 0);
    b0     	 : out std_logic_vector(13 downto 0);
    b1     	 : out std_logic_vector(13 downto 0);
    b2     	 : out std_logic_vector(13 downto 0);
    b3     	 : out std_logic_vector(13 downto 0);
    b4     	 : out std_logic_vector(13 downto 0));
end read_input;

architecture beh of read_input is

begin 
  b0 <= conv_std_logic_vector(-51, 14);
  b1 <= conv_std_logic_vector(-112, 14);
  b2 <= conv_std_logic_vector(419, 14);
  b3 <= conv_std_logic_vector(2176, 14);
  b4 <= conv_std_logic_vector(3323, 14);

  process(Clk, Rst_n)
    file fp_in : text open READ_MODE is "./sim/samples.txt";
    variable line_in_1,line_in_2,line_in_3 : line;
    variable x_1, x_2,x_3 : integer;
  begin
    if Rst_n = '0' then
      Dout_1 <= (others => '0') after 1 ns;
	  Dout_2 <= (others => '0') after 1 ns;
	  Dout_3 <= (others => '0') after 1 ns;
      Vout(0) <= '0' after 1 ns;
	  Vout(1) <= '0' after 1 ns;
	  Vout(2) <= '0' after 1 ns;
    elsif CLK'event and CLK = '1' then 
      if not endfile(fp_in) then
        readline(fp_in, line_in_1);
        read(line_in_1, x_1);
        Dout_1 <= conv_std_logic_vector(x_1, 14) after 1 ns;
		Vout(0) <= '1' after 1 ns;
		if not endfile(fp_in) then
        	readline(fp_in, line_in_2);
        	read(line_in_2, x_2);
        	Dout_2 <= conv_std_logic_vector(x_2, 14) after 1 ns;
			Vout(1) <= '1' after 1 ns; 
		
			if not endfile(fp_in) then
        		readline(fp_in, line_in_3);
        		read(line_in_3, x_3);
        		Dout_3 <= conv_std_logic_vector(x_3, 14) after 1 ns;
				Vout(2) <= '1' after 1 ns;  
			else 
				Vout(2) <= '0' after 1 ns;
			end if;
		else 
			Vout(1) <= '0' after 1 ns; 
			Vout(2) <= '0' after 1 ns;
		end if;      
	  else
        Vout(0) <= '0' after 1 ns;
	  	Vout(1) <= '0' after 1 ns; 
	  	Vout(2) <= '0' after 1 ns;
      end if;
    end if;
  end process;

end beh;

