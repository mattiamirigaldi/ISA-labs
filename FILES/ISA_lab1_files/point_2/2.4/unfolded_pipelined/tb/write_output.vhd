library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity write_output is
  port (
    Clk     : in std_logic;
    Rst_n   : in std_logic;
    Vin   	: in std_logic_vector(2 downto 0);
    Din_1   : in std_logic_vector(13 downto 0);
    Din_2   : in std_logic_vector(13 downto 0);
    Din_3   : in std_logic_vector(13 downto 0));
end write_output;

architecture beh of write_output is

begin 
  process(Clk, Rst_n)
  file res_fp : text open WRITE_MODE is "./sim/results_vhd.txt";
  variable line_out_1,line_out_2,line_out_3 : line;
  begin
    if Rst_n = '0' then
      null;
    elsif Clk'event and Clk = '1' then
      if (Vin(0) = '1') then
        write(line_out_1, conv_integer(signed(Din_1)));
        writeline(res_fp, line_out_1);
		if (Vin(1) = '1') then
      	  write(line_out_2, conv_integer(signed(Din_2)));
     	  writeline(res_fp, line_out_2);
		  if (Vin(2) = '1') then
        	write(line_out_3, conv_integer(signed(Din_3)));
        	writeline(res_fp, line_out_3);
		  end if;
		end if; 
      end if;
    end if;
  end process;
end beh;


