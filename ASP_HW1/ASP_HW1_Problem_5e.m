clear all

R=[1.1 0.5 0.1;0.5 1.1 0.5;0.1 0.5 1.1];
p=[0.5;-0.4;-0.2];
sd2=1.0;


re_w_0=-2:0.04:2;
re_w_2=-2:0.04:2;
[xx, yy] = meshgrid(re_w_0,re_w_2);
J=zeros(size(xx));
min_j=10000000;
min_x=0;
min_y=0;
for k=1:101
    for l=1:101
        w0=xx(k,l);
        w1=-0.7683;
        w2=yy(k,l);
        w=[w0;w1;w2];
        J(k,l)=ASP_Wiener_MSE(R,w,p,sd2);
        if J(k,l)<min_j
            min_x=k;
            min_y=l;
            min_j=J(k,l);
        end
    end
end
hold on
contour(xx, yy, J,[0.35,0.6,1,2,3,4,5],'ShowText','on')
plot(xx(min_x,min_y),yy(min_x,min_y),"ro");
text(xx(min_x,min_y),yy(min_x,min_y),{"min J", "Re\{w_0\}="+num2str(xx(min_x,min_y)),"Re\{w_2\}="+num2str(yy(min_x,min_y)),"J_{min}="+num2str(min_j)})
xlabel("Re\{w_0\}")
ylabel("Re\{w_2\}")
zlabel("J")
