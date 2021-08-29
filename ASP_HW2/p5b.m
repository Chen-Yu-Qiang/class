clear all
load('ASP_Problem_5.mat')
x=filter([1 1],[1 -1/6 -1/6],v.');
M=1;
L=1000;
rx=[];
pf1=0;
pb1=0;
for n=1:L
    if n-M>0
        xnk=flip(x(n-M:n));
        rx=x(n)*conj(xnk.');
    else
        xnk=flip([zeros(-(n-M)+1,1);x(1:n)]);
        rx=x(n)*conj(xnk.');
    end
    [a,P,kappa] = ASP_Levinson_Durbin(rx);
    if n>1
    f1(n)=[1,conj(kappa)]*[x(n);x(n-1)];
    b1(n)=[kappa,1]*[x(n);x(n-1)];
    
    pf1=pf1+(1/L)*(abs(f1(n)))^2;
    pb1=pb1+(1/L)*(abs(b1(n)))^2;
    end
end
figure
subplot(2,1,1)
plot(real(f1))
title("Re\{f_1\}")
subplot(2,1,2)

plot(imag(f1))
title("Im\{f_1\}")
figure
subplot(2,1,1)
plot(real(b1))
title("Re\{b_1\}")
subplot(2,1,2)
plot(imag(b1))
title("Im\{b_1\}")
pf1
pb1