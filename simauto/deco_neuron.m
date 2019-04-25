% funcao para decodificar resultados obtidos pela arquitetura de hardware
% do neurônio de 4 entradas
% Estima-se o MSE usando a funcao my_nuron como modelo de referencia

close all
clc
clear all
N=100; % numero de vetores de teste aleatorios
EW=8; % tamanho do expoente
FW=18; % tamanho da mantissa

bin_outneuron=textread('res_neuron.txt', '%s');
x1=textread('floatx1.txt', '%f');
x2=textread('floatx2.txt', '%f');
x3=textread('floatx3.txt', '%f');
x4=textread('floatx4.txt', '%f');
w1=textread('floatw1.txt', '%f');
w2=textread('floatw2.txt', '%f');
w3=textread('floatw3.txt', '%f');
w4=textread('floatw4.txt', '%f');
bias=textread('floatbias.txt', '%f');

result_hw=zeros(N,1);
result_sw=zeros(N,1);
for i=1:N-1
    result_hw(i,1)=bin2float(cell2mat(bin_outneuron(i)),EW,FW);
    x = [x1(i) x2(i) x3(i) x4(i)];
    w = [w1(i) w2(i) w3(i) w4(i)];
    b = bias(i);
    result_sw(i) = my_neuron(x,w,b); %x1(i)*w1 + x2(i)*w2 + x3(i)*w3 + bias;
    erro(i) = sum((result_hw(i,:) - result_sw(i,:)).^2);
end

result_hw(1:10,:)
result_sw(1:10,:)
MSE = sum(erro)/N
plot(erro)

