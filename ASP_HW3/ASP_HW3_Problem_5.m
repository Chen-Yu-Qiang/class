load('ASP_HW3_Problem_5.mat', 'matV')

%% (a) LMS u=0.1
e_r_n=[];
for i=1:10
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_LMS(0.1, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:10
        j(n)=j(n)+0.1*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)
%% (a) LMS u=0.2
e_r_n=[];
for i=1:10
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_LMS(0.2, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:10
        j(n)=j(n)+0.1*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

%% (a) NLMS u=0.2
e_r_n=[];
for i=1:10
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_NLMS(0.2, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:10
        j(n)=j(n)+0.1*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

%% (a) NLMS u=0.8
e_r_n=[];
for i=1:10
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_NLMS(0.8, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:10
        j(n)=j(n)+0.1*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

%% (a) RLS lambda=0.75 delta=0.01
e_r_n=[];
for i=1:10
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_RLS(0.01,0.75, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:10
        j(n)=j(n)+0.1*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

%% (a) RLS lambda=0.75 delta=0.1
e_r_n=[];
for i=1:10
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_RLS(0.1,0.75, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:10
        j(n)=j(n)+0.1*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

%% (a) RLS lambda=0.95 delta=0.01
e_r_n=[];
for i=1:10
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_RLS(0.01,0.95, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:10
        j(n)=j(n)+0.1*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

grid on
title("ASP HW3 problem 5(a)")
xlabel("迭代次數n")
ylabel("均方誤差")
legend("LMS \mu=0.1","LMS \mu=0.2","NLMS \mu=0.2","NLMS \mu=0.8","RLS \lambda=0.75 \delta=0.01","RLS \lambda=0.75 \delta= 0.1","RLS \lambda=0.95 \delta= 0.01")
figure
%% (b) LMS u=0.1
e_r_n=[];
for i=1:1000
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_LMS(0.1, x, d);
    e_r_n(i,:)=e;
end
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
    [~,~,e]=ASP_LMS(0.2, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:1000
        j(n)=j(n)+0.001*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

%% (b) NLMS u=0.2
e_r_n=[];
for i=1:1000
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_NLMS(0.2, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:1000
        j(n)=j(n)+0.001*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

%% (b) NLMS u=0.8
e_r_n=[];
for i=1:1000
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_NLMS(0.8, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:1000
        j(n)=j(n)+0.001*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

%% (b) RLS lambda=0.75 delta=0.01
e_r_n=[];
for i=1:1000
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_RLS(0.01,0.75, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:1000
        j(n)=j(n)+0.001*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

%% (b) RLS lambda=0.75 delta=0.1
e_r_n=[];
for i=1:1000
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_RLS(0.1,0.75, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:1000
        j(n)=j(n)+0.001*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)
%% (b) RLS lambda=0.95 delta=0.01
e_r_n=[];
for i=1:1000
    x=filter([1 0.1],[1 -1/6 -1/6],matV(i,:).');
    d=matV(i,:).';
    [~,~,e]=ASP_RLS(0.01,0.95, x, d);
    e_r_n(i,:)=e;
end
j=zeros(500,1);
for n=1:500
    for i=1:1000
        j(n)=j(n)+0.001*(abs(e_r_n(i,n)))^2;
    end
end
hold on
plot(j,"lineWidth",0.5)

grid on
title("ASP HW3 problem 5(b)")
xlabel("迭代次數n")
ylabel("均方誤差")
legend("LMS \mu=0.1","LMS \mu=0.2","NLMS \mu=0.2","NLMS \mu=0.8","RLS \lambda=0.75 \delta=0.01","RLS \lambda=0.75 \delta= 0.1","RLS \lambda=0.95 \delta= 0.01")
