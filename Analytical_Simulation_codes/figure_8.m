clc
close all
clear all

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

data = rand(1,L)>0.5;

for ii=1:1:5
    sum = sum + Cj_fun(ii);
    sum1 = sum1 + data(ii)*Cj_fun(ii);
end

avg = sum + lambda*T;
avg1 = avg + 20;
final_term = 100000;

for jj=1:1:length(x)
    factor = avg.^(x(jj));
    fact = factorial(x(jj));
    final(jj) = (exp(-avg)*(factor))/fact;
 
    factor1 = avg1.^(x(jj));
    final1(jj) = (exp(-avg1)*(factor1))/fact;
    
    lam1 = lambda*T + sum1;
    lam2 = lam1 + 20;
    first_term = Q_fun(lam1, x(jj));
    last_term = 1 - Q_fun(lam2, x(jj));
    final_term_next = 0.5*(first_term + last_term);
    
    if(final_term_next < final_term)
        final_term = final_term_next;
        final_tao = x(jj);
    end
end

t3 = 20/avg;
t2 = log(1+t3); 
t1 = 20/t2;

figure;
plot(x,final,'s-');
hold on
plot(x,final1,'o-');
stem(t1, 0.08, 'Marker','none');
stem(final_tao, 0.08, 'Marker', 'none');
h= legend('App. distr. when si=0', 'App. distr. when si=1', 'threshold from equiprobability', 'optimal threshold');
h.FontSize = 7;
rect = [0.65, 0.70, 0.25, 0.2];
set(h, 'Position', rect);

%---- functions ------

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
    u3 = lambda.^n
    u2 = exp(-lambda)*u3;
    ans = u2/u1;
end