snr = [-5:50];
lambda0 = 100;
T = 30*9*(10^-6);
d = 500*(10^-9);
r = 45*(10^-9);
L=5;
time_slot = [1:5];
capD = 4.265*(10^-10);
i=1;
ri = zeros(56,5);
sj = randn(1, length(time_slot))>0.5;
P_0 = (r/d)*(erfc((d-r)/sqrt(4*capD*i*T))-erfc((d-r)/sqrt(4*capD*(i-1)*T)));
Ntx = 2.*lambda0.*T.*(10.^(snr./10))./P_0;
for k = 1:length(Ntx)
    for i = 1:length(time_slot)
        P_i1(i) = (r/d)*(erfc((d-r)/sqrt(4*capD*i*T))-erfc((d-r)/sqrt(4*capD*(i-1)*T)));
    end
    for j = 1:length(time_slot)
        cj(j) = Ntx(k).*P_i1(j);
    end
    c0 = 54;
    sum1 = sum(sj.*cj);
    avg = (lambda0*T + sum1);
    avg1 = avg + sj.*c0;
    ri(k,:) = poissrnd(avg1);
       %tau(k) = cj(1)/log(1 + (cj(1)/(sum(cj/2)+(lambda0*T))));
end
ri=reshape(ri, [1, 56*5])
%ri = reshape
sj=repmat(sj, 1, 56)
A = [ri; sj];
writematrix(A, 'MC_Ntx.csv');

%writematrix(sj, 'MC_Ntx.csv');