clear all


dt = 0.2;
t  = 0:dt:10;

Nsamples = length(t);

x_ul = zeros(Nsamples, 1);
x_ir = zeros(Nsamples, 1);
x_fs = zeros(Nsamples, 1);
G = zeros(Nsamples, 1);
sigma_ul = 0.15;
sigma_ir = 0.55;
mu = 100; 
for k=1:Nsamples
  x_ul(k) = mu + sigma_ul*randn;  
  x_ir(k) = mu + sigma_ir*randn;
end

%G(1) = sigma_ul / (sigma_ul + sigma_ir);
%for k=1:Nsamples
%  x_fs(t) = x_ul + G(k)*x_ir;
%  sigma_ul = sigma_ul - G*sigma_ul;
%end

%figure
%plot(t, Xsaved, 'o-')
%hold on
%plot(t, Zsaved, 'r:*')