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



clear all
syms fff
load('ASP_Problem_5.mat');
x=filter([1 1],[1 -1/6 -1/6],v.');
L=1000;
pf=[];
pb=[];
Pm=zeros(10,1);
rx=zeros(11,1);
for M=0:10
    for n=1:L
        if n-M>0
            rx(M+1)=rx(M+1)+(x(n)*conj(x(n-M)))/1000;
        end
    end
end
for M=1:10
    pf1=0;
    pb1=0;
    for n=1:L
        [a,P,kappa] = ASP_Levinson_Durbin(rx);
        Pm(M)=Pm(M)+(1/L)*P(M+1);
        if n>1
            f(1,n)=[1,conj(kappa(1))]*[x(n);x(n-1)];
            b(1,n)=[kappa(1),1]*[x(n);x(n-1)];
            for m=2:M
                f(m,n)=[1,conj(kappa(m))]*[f(m-1,n);b(m-1,n-1)];
                b(m,n)=[kappa(m),1]*[f(m-1,n);b(m-1,n-1)];
            end
        pf1=pf1+(1/L)*(abs(f(M,n)))^2;
        pb1=pb1+(1/L)*(abs(b(M,n)))^2;
        end
    end
    pf(M)=pf1;
    pb(M)=pb1;

end
figure
hold on
plot(pf,"linewidth",1)
plot(pb,"linewidth",1)
plot(Pm,"linewidth",1)
sx1=log(2+exp(j*2*pi*fff)+exp(-j*2*pi*fff)+10^(-9));
sx2=log(10/9+2/3*cos(2*pi*fff));
sx3=log(5/4-cos(2*pi*fff));
bom=exp(int(sx1,-0.5,0.5)-(int(sx2,-0.5,0.5))-(int(sx3,-0.5,0.5)));
bom=vpa(bom);
plot([1,10],[bom,bom])
legend("$\hat{P}_{f,m}$","$\hat{P}_{b,m}$","$P_m$","bound",'Interpreter','latex')
xlabel("m")