load('ASP_HW3_Problem_5.mat', 'matV')

%% (b) LMS u=0.1
e_r_n=[];
u_min=[];
for i=1:1000
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e,b]=ASP_LMS(0.1, x, d);
    u_min(i)=b;
    e_r_n(i,:)=e;
end
figure
hold on
plot(u_min)
plot(0.1*ones(1000,1))
j=zeros(500,1);
for n=1:500
    for i=1:1000
        j(n)=j(n)+0.001*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)
%% (b) LMS u=0.2
e_r_n=[];
for i=1:1000
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e,b]=ASP_LMS(0.2, x, d);
    
    u_min(i)=b;
    e_r_n(i,:)=e;
end
figure
hold on
plot(u_min)
plot(0.2*ones(1000,1))
grid on
title("problem6")
xlabel("R")
legend("上界","\mu")
j=zeros(500,1);
for n=1:500
    for i=1:1000
        j(n)=j(n)+0.001*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)
