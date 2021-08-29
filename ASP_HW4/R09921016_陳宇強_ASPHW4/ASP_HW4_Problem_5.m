clear all
load('ASP_HW4_Problem_5.mat')

K_n_n_1={};
x_n_yn_1=[];
G={};
a=[];
K={};
x=[];
for n=1:301
    F_n_n1=inv(F_n1_n);
    if n==1
        K_n_n_1{n}=eye(4);
        x_n_yn_1(:,1)=zeros(4,1);
    else
        K_n_n_1{n}=K_n1_n{n-1};
        x_n_yn_1(:,n)=x_n1_yn(:,n-1);
    end
    
    
    G{n}=F_n1_n*K_n_n_1{n}*C_n'*inv(C_n*K_n_n_1{n}*C_n'+Q2_n);
    a(:,n)=Y_tilde(:,n)-C_n*x_n_yn_1(:,n);
    x_n1_yn(:,n)=F_n1_n*x_n_yn_1(:,n)+G{n}*a(:,n);
    K{n}=K_n_n_1{n}-F_n_n1*G{n}*C_n*K_n_n_1{n};
    K_n1_n{n}=F_n1_n*K{n}*F_n1_n'+Q1_n;
    x(:,n)=F_n_n1*x_n1_yn(:,n);
end

figure
for i=1:4
    subplot(4,1,i)
    plot(real(x(i,:)))
    grid on
    ylabel("value")
    title("ASP HW4 Problem5(b.i)--$\Re\{\hat{x}_"+int2str(i)+"(n|y_n)\}$",'Interpreter','latex')
    xlabel("Time index n")
end
figure
for i=1:4
    subplot(4,1,i)
    plot(imag(x(i,:)))
    grid on
    ylabel("value")
    title("ASP HW4 Problem5(b.ii)--$\Im\{\hat{x}_"+int2str(i)+"(n|y_n)\}$",'Interpreter','latex')
    xlabel("Time index n")
end
figure
for i=1:4
    subplot(4,1,i)
    plot(abs(x(i,:)))
    grid on
    ylabel("value")
    title("ASP HW4 Problem5(b.iii)--$|\hat{x}_"+int2str(i)+"(n|y_n)|$",'Interpreter','latex')
    xlabel("Time index n")
end
figure
for i=1:4
    subplot(4,1,i)
    plot(unwrap(angle(x(i,:))))
    grid on
    ylabel("value")
    title("ASP HW4 Problem5(b.iv)--$\angle\hat{x}_"+int2str(i)+"(n|y_n)$",'Interpreter','latex')
    xlabel("Time index n")
end
%% 
clear F_n1_n x_n1_yn Y_tilde
F_n1_n=eye(8);
F_n1_n(1,2)=1;
F_n1_n(3,4)=1;
F_n1_n(5,6)=1;
F_n1_n(7,8)=1;
Q2_n=eye(4);
Q1_n=eye(8)*0.001;
C_n=zeros(4,8);
C_n(1,1)=1;
C_n(2,3)=1;
C_n(3,5)=1;
C_n(4,7)=1;
for i=1:4
    Y_tilde(i,:)=unwrap(angle(x(i,:)));
end
K_n_n_1={};
x_n_yn_1=[];
G={};
a=[];
K={};
x=[];
for n=1:301
    F_n_n1=inv(F_n1_n);
    if n==1
        K_n_n_1{n}=eye(8);
        x_n_yn_1(:,1)=zeros(8,1);
    else
        K_n_n_1{n}=K_n1_n{n-1};
        x_n_yn_1(:,n)=x_n1_yn(:,n-1);
    end
    
    
    G{n}=F_n1_n*K_n_n_1{n}*C_n'*inv(C_n*K_n_n_1{n}*C_n'+Q2_n);
    a(:,n)=Y_tilde(:,n)-C_n*x_n_yn_1(:,n);
    x_n1_yn(:,n)=F_n1_n*x_n_yn_1(:,n)+G{n}*a(:,n);
    K{n}=K_n_n_1{n}-F_n_n1*G{n}*C_n*K_n_n_1{n};
    K_n1_n{n}=F_n1_n*K{n}*F_n1_n'+Q1_n;
    x(:,n)=F_n_n1*x_n1_yn(:,n);
end


for i=1:4
    subplot(4,1,i)
    plot(x(2*i,:))
    grid on
    ylabel("value")
    title("ASP HW4 Problem5(c)--$\hat{\omega}_"+int2str(i)+"(n|y_n)$",'Interpreter','latex')
    xlabel("Time index n")
end

figure
for i=1:4
    subplot(4,1,i)
    plot(x(2*i-1,:))
    grid on
    ylabel("value")
    title("ASP HW4 Problem5(b.i)--$\hat{\theta}_"+int2str(i)+"(n|y_n)$",'Interpreter','latex')
    xlabel("Time index n")
end

mean(x(2,50:end))
mean(x(4,50:end))
mean(x(6,50:end))
mean(x(8,50:end))