module tb_fir_filter();


wire [13:0]Din_tb[2:0];
wire [2:0]Vin_tb;
wire Rst_n_tb;
wire Ck_tb;
wire [13:0]b_tb[4:0];
wire [2:0]Vout_tb;
wire [13:0]Dout_tb[2:0];


clk_gen CG(.CLK(Ck_tb),
           .RST_n(Rst_n_tb)
);

read_input RI(.CLK(Ck_tb),
              .RST_n(Rst_n_tb),
              .VOUT(Vin_tb),
              .DOUT_1(Din_tb[0]),
			  .DOUT_2(Din_tb[1]),
			  .DOUT_3(Din_tb[2]),
              .B0(b_tb[0]),
              .B1(b_tb[1]),
              .B2(b_tb[2]),
              .B3(b_tb[3]),
              .B4(b_tb[4])
);

write_output WO(.CLK(Ck_tb),
              .RST_n(Rst_n_tb), 
              .VIN (Vout_tb),
			  .DIN_1(Dout_tb[0]),
			  .DIN_2(Dout_tb[1]),
              .DIN_3(Dout_tb[2])
);              

fir_filter_unfolded_3 DUT( 
               .DIN_1(Din_tb[0]),
			   .DIN_2(Din_tb[1]),
               .DIN_3(Din_tb[2]), 
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
