% PCR 2019
% Engenharia Eletrônica
% Universidade de Brasilia
% 
% funcao my_meuron.m para N entradas
% recebe vetor de entradas x, w e bias

function out_neuron = my_neuron(x, w, b)

campo_induzido = sum(x.*w) + b;
% aplica funcao ativacao linear
if (campo_induzido >= 1.0)
    out_neuron = 1.0;
elseif campo_induzido <= 0.0
    out_neuron = 0.0;
else
    out_neuron = campo_induzido;
end
