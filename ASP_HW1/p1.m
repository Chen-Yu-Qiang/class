R=[1.1 0.5 0.1;0.5 1.1 0.5;0.1 0.5 1.1];
p=[0.5;-0.4;-0.2];
sd2=1.0;
syms w w0 w1 w2
w=[w0;w1;w2];
ASP_Wiener_MSE(R,w,p,sd2)

w_opt=inv(R)*p;
ASP_Wiener_MSE(R,w_opt,p,sd2)


j=[];
re_w_0=-5:0.1:5;
for k=1:101;
    w0=re_w_0(k)+(1j);
    w1=-0.5+j;
    w2=-1;
    w=[w0;w1;w2];
    j(k)=ASP_Wiener_MSE(R,w,p,sd2)
end
plot(j)