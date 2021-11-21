module tb_fir_filter_unfolded();


wire [13:0]Din_tb[2:0];
wire [2:0]Vin_tb;
wire Rst_n_tb;
wire Ck_tb;
wire [13:0]b_tb[4:0];
wire [2:0]Vout_tb;
wire [13:0]Dout_tb[2:0];


clk_gen CG(.Clk(Ck_tb),
           .Rst_n(Rst_n_tb)
);

read_input RI(.Clk(Ck_tb),
              .Rst_n(Rst_n_tb),
              .Vout(Vin_tb),
              .Dout_1(Din_tb[0]),
			  .Dout_2(Din_tb[1]),
			  .Dout_3(Din_tb[2]),
              .b0(b_tb[0]),
              .b1(b_tb[1]),
              .b2(b_tb[2]),
              .b3(b_tb[3]),
              .b4(b_tb[4])
);

write_output WO(.Clk(Ck_tb),
              .Rst_n(Rst_n_tb), 
              .Vin (Vout_tb),
			  .Din_1(Dout_tb[0]),
			  .Din_2(Dout_tb[1]),
              .Din_3(Dout_tb[2])
);              

fir_filter_unfolded_3_Nb14_N8_s7_k3 DUT(
               .Din_1(Din_tb[0]),
			   .Din_2(Din_tb[1]),
               .Din_3(Din_tb[2]), 
               .Vin(Vin_tb), 
               .Rst_n(Rst_n_tb), 
               .Ck(Ck_tb), 
               .b0(b_tb[0]),
               .b1(b_tb[1]),
               .b2(b_tb[2]),
               .b3(b_tb[3]),
               .b4(b_tb[4]),
               .Vout(Vout_tb), 
               .Dout_1(Dout_tb[0]),
			   .Dout_2(Dout_tb[1]),
			   .Dout_3(Dout_tb[2])
);
endmodule
