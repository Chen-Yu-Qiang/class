clear all

R=[1.1 0.5 0.1;0.5 1.1 0.5;0.1 0.5 1.1];
p=[0.5;-0.4;-0.2];
sd2=1.0;


re_w_0=-5:0.1:5;
im_w_0=-4:0.1:4;
[xx, yy] = meshgrid(re_w_0,im_w_0);
J=zeros(size(xx));
for k=1:81
    for l=1:101
        w0=xx(k,l)+yy(k,l)*(1j);
        w1=1j+1;
        w2=0.5;
        w=[w0;w1;w2];
        J(k,l)=ASP_Wiener_MSE(R,w,p,sd2);
    end
end
hold on
surf(xx, yy, J)
xlabel("Re\{w_0\}")
ylabel("Im\{w_0\}")
zlabel("J")
colorbar