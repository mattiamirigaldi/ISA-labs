library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity write_output is
  port (
    CLK   : in std_logic;
    RST_n : in std_logic;
    VIN   : in std_logic;
    DIN   : in std_logic_vector(13 downto 0));
end write_output;

architecture beh of write_output is

begin 
  process(CLK, RST_n)
  file res_fp : text open WRITE_MODE is "./sim/results_vhd.txt";
  variable line_out : line;
  begin
    if RST_n = '0' then
      null;
    elsif CLK'event and CLK = '1' then
      if (VIN = '1') then
        write(line_out, conv_integer(signed(DIN)));
        writeline(res_fp, line_out);
      end if;
    end if;
  end process;
end beh;


