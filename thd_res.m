fp=fopen('results.txt','r');
p = fscanf(fp,'%d');
fclose(fp);
res=p';
r_init=thd(res);

fp=fopen('res_test_2.txt','r');
p = fscanf(fp,'%d');
fclose(fp);
res=p';
r=thd(res);