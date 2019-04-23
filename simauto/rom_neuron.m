clc
clear all
close all
N=100; % numero de vetores de teste aleatorios
EW=8; % tamanho do expoente
FW=18; % tamanho da mantissa
% valores de entrada entre 0 e 1.0
max_in = 20.0 % pesos com valores entre 0 e 10.0

floatx1 = fopen('floatx1.txt','w');
floatx2 = fopen('floatx2.txt','w');
floatx3 = fopen('floatx3.txt','w');
floatx4 = fopen('floatx4.txt','w');
floatw1 = fopen('floatw1.txt','w');
floatw2 = fopen('floatw2.txt','w');
floatw3 = fopen('floatw3.txt','w');
floatw4 = fopen('floatw4.txt','w');
floatbias = fopen('floatbias.txt','w');

binx1 = fopen('x1.txt','w');
binx2 = fopen('x2.txt','w');
binx3 = fopen('x3.txt','w');
binx4 = fopen('x4.txt','w');
binw1 = fopen('w1.txt','w');
binw2 = fopen('w2.txt','w');
binw3 = fopen('w3.txt','w');
binw4 = fopen('w4.txt','w');
binbias = fopen('bias.txt','w');

% rand('seed',06111991); % seed for random number generator
rand('twister',06111991); % seed for random number generator
for i=1:N
    x1=rand();
    x2=rand();
    x3=rand();
    x4=rand();
    w1=max_in*(rand()-0.5);
    w2=max_in*(rand()-0.5);
    w3=max_in*(rand()-0.5);
    w4=max_in*(rand()-0.5);
    bias=max_in*(rand()-0.5);
    
    x1bin=float2bin(EW,FW,x1);
    x2bin=float2bin(EW,FW,x2);
    x3bin=float2bin(EW,FW,x3);
    x4bin=float2bin(EW,FW,x4);
    w1bin=float2bin(EW,FW,w1);
    w2bin=float2bin(EW,FW,w2);
    w3bin=float2bin(EW,FW,w3);
    w4bin=float2bin(EW,FW,w4);
    biasbin=float2bin(EW,FW,bias);
    
    fprintf(floatx1,'%f\n',x1);
    fprintf(floatx2,'%f\n',x2);
    fprintf(floatx3,'%f\n',x3);
    fprintf(floatx4,'%f\n',x4);
    fprintf(floatw1,'%f\n',w1);
    fprintf(floatw2,'%f\n',w2);
    fprintf(floatw3,'%f\n',w3);
    fprintf(floatw4,'%f\n',w4);
    fprintf(floatbias,'%f\n',bias);
    
    fprintf(binx1,'%s\n',x1bin);
    fprintf(binx2,'%s\n',x2bin);
    fprintf(binx3,'%s\n',x3bin);
    fprintf(binx4,'%s\n',x4bin);
    fprintf(binw1,'%s\n',w1bin);
    fprintf(binw2,'%s\n',w2bin);
    fprintf(binw3,'%s\n',w3bin);
    fprintf(binw4,'%s\n',w4bin);
    fprintf(binbias,'%s\n',biasbin);
end

fclose(floatx1);
fclose(floatx2);
fclose(floatx3);
fclose(floatx4);
fclose(floatw1);
fclose(floatw2);
fclose(floatw3);
fclose(floatw4);
fclose(floatbias);

fclose(binx1);
fclose(binx2);
fclose(binx3);
fclose(binx4);
fclose(binw1);
fclose(binw2);
fclose(binw3);
fclose(binw4);
fclose(binbias);