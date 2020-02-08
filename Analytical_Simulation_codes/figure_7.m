
snrdb =1:1:60;
snr = 10.^(snrdb/10);

lambda = 100;
r = 45e-9;
d = 500e-9;
D = 4.265e-10;
delta_T = 9e-6;
T = 30*delta_T;
L = 5;
global sum_Cj;
sum=0;
sum1=0;
x = 0:1:60;
sum_Cj=0;
Co = zeros(1,length(snrdb));

data = rand(1,L)>0.5;

for ii=1:1:5
    sum = sum + Cj_fun(ii);
    sum1 = sum1 + data(ii)*Cj_fun(ii);
end
avg = sum + lambda*T;
avg1 = avg + 20;
final_term = 100000;

for ii=1:1:length(snrdb)
    Co(ii) = snr(ii)*2*lambda*T;
    a = sec_term(Co(ii), avg);
    Pe(ii)= 0.5 - 0.5*(a);   % PLOT FOR SUB OPTIMAL APPROACH
    
    for jj=1:1:length(x)      % finding min tao for the optimal approach for a given Co 
        lam1 = lambda*T + sum1;
        lam2 = lam1 + Co(ii);
        first_term = Q_fun(lam1, x(jj));
        last_term = 1 - Q_fun(lam2, x(jj));
        final_term_next = 0.5*(first_term + last_term);

        if(final_term_next < final_term)
            final_term = final_term_next;
            final_tao = x(jj);
        end
    end
    
    b = sec_term1(Co(ii), avg, final_tao);
    Pe1(ii) = 0.5 - 0.5*(b);
end

figure;
plot(snrdb, Pe, 's-');
hold on
plot(snrdb, Pe1, 'o-');

legend('Optimal zero bit mem. Rx. BER', 'Equiprobability zer bit mem. Rx. BER');

%---- functions ------
function ans1 = sec_term(Co1, avg1)
    t3 = Co1/avg1;
    t2 = log(1+t3); 
    t1 = Co1/t2;  % tao
    
    ans1 = 0;
    lg0 = avg1;
    lg1 = avg1 + Co1;
    
    for jj=0:1:t1
        d1 = lg0^(jj) * exp(-lg0);
        d2 = lg1^(jj) * exp(-lg1);
        ans1 = ans1 + (d1-d2)/factorial(jj);
    end
end

function ans2 = sec_term1(Co1, avg1, final_tao)
    ans2 = 0;
    lg0 = avg1;
    lg1 = avg1 + Co1;
    
    for jj=0:1:final_tao
        d1 = lg0^(jj) * exp(-lg0);
        d2 = lg1^(jj) * exp(-lg1);
        ans2 = ans2 + (d1-d2)/factorial(jj);
    end
end

function sum_Cj = Cj_fun(j)
    Ntx = 10^2;
    global sum_Cj;
    sum_Cj = sum_Cj + Ntx*prob_j(j);
    %Ntx*prob_j(j)
end

function y = prob_j(j)
    lambda = 100;
    r = 45e-9;
    d = 500e-9;
    D = 4.265e-10;
    delta_T = 9e-6;
    T = 30*delta_T;
    L = 5;
    
   x = r/d;
   t1 = ((d-r)/(sqrt(4*D*(j+1)*T)));
   t2 = ((d-r)/(sqrt(4*D*(j)*T)));
   y = x*(erfc(t1) - erfc(t2));  
end

function ans = Q_fun(lambda, n)
    u1 = factorial(n);
    u3 = lambda.^n;
    u2 = exp(-lambda)*u3;
    ans = u2/u1;
end