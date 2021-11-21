module tb_fir_filter();


wire [13:0]Din_tb;
wire Vin_tb;
wire Rst_n_tb;
wire Ck_tb;
wire [13:0]b_tb[4:0];
wire Vout_tb;
wire [13:0]Dout_tb;

clk_gen CG(.CLK(Ck_tb),
           .RST_n(RST_n_tb));

read_input RI(.CLK(Ck_tb),
              .RST_n(RST_n_tb),
              .VOUT(Vin_tb),
              .DOUT(Din_tb),
              .B0(b_tb[0]),
              .B1(b_tb[1]),
              .B2(b_tb[2]),
              .B3(b_tb[3]),
              .B4(b_tb[4]));

write_output WO(.CLK(Ck_tb),
              .RST_n(RST_n_tb), 
              .VIN(Vout_tb),
              .DIN(Dout_tb));              

fir_filter_mod_Nb14_N8_s7 DUT( 
               .Din(Din_tb), 
               .Vin(Vin_tb), 
               .Rst_n(RST_n_tb), 
               .Ck(Ck_tb), 
               .b0(b_tb[0]),
               .b1(b_tb[1]),
               .b2(b_tb[2]),
               .b3(b_tb[3]),
               .b4(b_tb[4]),
               .Vout(Vout_tb), 
               .Dout(Dout_tb));
endmodule
