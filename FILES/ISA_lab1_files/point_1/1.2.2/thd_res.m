fp=fopen('resultsC/resN-1.txt','r');
p = fscanf(fp,'%d');
fclose(fp);
res=p';
r_init=thd(res);

fp=fopen('resultsC/resNB+5.txt','r');
p = fscanf(fp,'%d');
fclose(fp);
res=p';
r1=thd(res);
%%RESULTS ONLY SHIFTING Y INSIDE THE FOR LOOP (multiplier on 14 bits, adder on less bits [myfir.c])
%-40.22 with NB+4 (5 bits shift)
%-35.77 with NB+5 (6 bits shift)
%-26.7 with NB+6 (7 bits shift)

fp=fopen('resultsC/resSHIFT7.txt','r');
p = fscanf(fp,'%d');
fclose(fp);
res=p';
r2=thd(res);
%%RESULTS shitfing Y and components INSIDE THE FOR LOOP of nbit=shift_val
%-38.8 with shift_val=6 (6 bits shift)
%-31.95 with shift_val=7 (7 bits shift)--> x and b on 14-7=7 bits, y on 8 bits
%-23.58 with shift_val=8 (8 bits shift)
