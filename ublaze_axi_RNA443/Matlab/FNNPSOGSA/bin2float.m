%Diego Felipe S�nchez G�mez
%Este programa convierte una cadena binaria en su
%correspondiete representacion en punto flutuante

%primero empezamos solo con la mantiza
%0
%10000000
%110 0000 0000 0000 0000 0000

function [f] = bin2float(num,EW,FW)
format long g;
% FW = 18; % FRAC_WIDTH (23 defautl) Tamano de la mantisa
% EW = 8; % EXP_WIDTH  (8 defautl)  Tamano del exponente
bias = ((2^EW)/2)-1;

A = num;
%     A= '010000100000001001001110111'; % tamanho mascara 27bits    
%     A= '010000000010000000000000000'; % tamanho mascara 27bits
%   A= '010000001000000000000000000'; % tamanho mascara 27bits
%   A= '001111111100000000000000000'; % tamanho mascara 27bits

%   A= '01000001100000111100100100001010'; % tamanho mascara 32bits

S = A(1);
E = A(2:EW+1);
M = A(EW+2:FW+EW+1);
e = 0;
m = 0;

% Toma signo y representa en bit de signo
if S == '0'
    s = 1;
else    
    s = -1;
end 

for i = 1:1:EW
    if E(i) == '1'
        e = e + 2^(EW-i);
    end
end 

e = e - bias;

for i = 1:1:FW
    if M(i) == '1'
      m = m + 2^(-i);
    end
end
format long g;
f = s*(1 + m)*2^(e);
