clear all

R=[1.1 0.5 0.1;0.5 1.1 0.5;0.1 0.5 1.1];
p=[0.5;-0.4;-0.2];
sd2=1.0;

J=[];
re_w_0=-5:0.1:5;
for k=1:101
    w0=re_w_0(k)+(1j);
    w1=1j-0.5;
    w2=-1;
    w=[w0;w1;w2];
    J(k)=ASP_Wiener_MSE(R,w,p,sd2);
end
[J_min,J_min_k]=min(J);
hold on
plot(re_w_0,J)
plot(re_w_0(J_min_k),J_min,"ro");
text(re_w_0(J_min_k),J_min,"min J, Re\{w_0\}="+num2str(re_w_0(J_min_k))+", J_{min}="+num2str(J_min))
xlabel("Re\{w_0\}")
ylabel("J")