%Daniel Mauricio Munoz Arboleda
%GRACO - UnB
%09 de Fevereiro de 2009

%Esta funcion recibe un numero tipo float
%y convierte en binario punto flotante segun padron IEE-754:
%Signo|Exponente 8 bits (bias = 127)|Mantisa 23 bits

function [out] = float2bin(EW,FW,A)

% FW = 23; % FRAC_WIDTH (23 defautl) Tamano de la mantisa
% EW = 8; % EXP_WIDTH  (8 defautl)  Tamano del exponente
bias = ((2^EW)/2)-1;
n_exp = 0;
% format long g;

% Toma signo y representa en bit de signo
if A >= 0
    s = '0';
else    
    s = '1';
end    
 
% Toma parte entera y convierte a binario
x=floor(abs(A));
x1=dec2bin(x);

% Toma parte decimal y convierte a binario
B=abs(A)-x;
for i=1:1:8*FW
    B = B*2;
    if B >= 1
        M(i) = '1';
        B = B-1;
    else
        M(i) = '0';
    end    
end

% Cuenta numero de bits de exponente
if A == 0
    n_exp = -bias;
    Mn = zeros(1,FW+EW+1);
elseif x1(1) == '1'
    n_exp = length(x1)-1;
else
    for i=1:1:5*FW
        if M(i)== '0'
            n_exp = n_exp - 1;
        else
            n_exp=n_exp-1;
            break;
        end    
    end
    Mn=M(i+1:5*FW);
end

% procesa exponente y convierte a binario
n_exp = n_exp + bias;
exp = dec2bin(n_exp);
nz=length(exp);
for i=1:1:EW
    if nz < EW
        exp = ['0',exp];
        nz=length(exp);
    end    
end    

% Contatena s|exp|x1(2:length)M
k=length(x1);
if abs(A) >= 1 
    x2=x1(2:k);
    h=[s,exp,x2,M];
else
    h=[s,exp,Mn];
end    

out =h(1:FW+EW+1);
% for i=1:1:FW+EW+1
%     if Y(i) == '1';
%         out(i) = 1;
%     else
%         out(i) = 0;
%     end    
% end





