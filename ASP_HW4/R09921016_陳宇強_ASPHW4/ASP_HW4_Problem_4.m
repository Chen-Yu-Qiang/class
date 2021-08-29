clear all
load('ASP_HW4_Problem_3.mat')
[M,K]=size(matX);
R=zeros(M);
for i=1:M
    R=R+(matX(:,i)*matX(:,i)')/M;
end
[v,d]=eig(R);
p=[];
t=[];
for i=0:0.0000001:10/180*pi
    p=[p 1/norm(v(:,3:end)'*A(i))^2];
    t=[t i];
    i
end

[~,pic]=findpeaks(p,t,'NPeaks',1,'SortStr','descend');
w=1/M*A(pic);
x=[];
y=[];
for t=1:K
    x=[x t];
    y=[y w'*matX(:,t)];
end
%save("ASP_HW4_y_hat_t","y")
figure
plot(abs(y))
function a=A(theta)
    a=[];
    for i=1:11
        a(i)=exp((1i)*2*pi*sin(theta)*(i-1)*0.5);
    end
    a=a.';
end