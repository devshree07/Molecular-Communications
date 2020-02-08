clear all;
close all;
tau = [20:120];
snr = [10:10:50];
L=5;
time_slot = [1:5];
lambda0 = 100;
T = 30*9*(10^-6);
r = 45*(10^-9);
d = 500*(10^-9);
D = 4.265*(10^-10);

for i = 1:length(time_slot)
    P_i1(i) = (r/d)*(erfc((d-r)/sqrt(4*D*i*T))-erfc((d-r)/sqrt(4*D*(i-1)*T)));
    ntx(i) = 2*lambda0*T*10^(snr(i)/10)/P_i1(1);
end
for j = 1:length(time_slot)
    cj(j) = ntx(j)*P_i1(j);

%tau = cj(1)/log(1 + (cj(1)/(sum(cj/2)+(lambda0*T))));
sj = randi([0, 1], 1, j);
%P_e = @(tau) 0.5*(qfunc((lambda0*T + sum(sj*cj)), tau) + 1 - qfunc((lambda0*T + sum(sj*cj) + c0), tau));
for i = 1:length(tau)
    P_e(i) = 0.5*(gammainc((lambda0*T + sum(sj.*cj)), tau(i)) + 1 - gammainc((lambda0*T + sum(sj.*cj) + cj(1)), tau(i)));
end
end

P_etau = (P_e)/(2^L);
%semilogy(snr,P_e);
xx=plot(tau, P_e)
legend('slot length 50T')
xlabel('threshold')
ylabel('BER')
%ylim([0.01 0.1]);
%xlim([20 120]);


figure;