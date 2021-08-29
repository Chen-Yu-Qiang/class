clc;
clear;

Mt=600;
g=10;
r0=0.3;
br=0.001;
Jr=1;
KT=25;
KA=1;
% 論文沒有提供真實數值的參數，只能自行假設和調整-----
cx=1;
nd=1;
ud=100;
ba=100;
brr=100;
% ----------------------------------------------------------------------
a11=(2*cx*ud-ba-brr)/Mt;
a12=(2*cx*nd)/Mt;
a21=-r0*cx*ud/Jr;
a22=(-r0*cx*nd-br)/Jr;
b11=-g;
b12=-1/Mt;
b23=KA*KT/Jr;

% Model
% continuous-time state-space model
A=[a11 a12; a21 a22];
B=[0; b23];
C=[1 0];
D=0;
CT_sys=ss(A,B,C,D)
% discrete-time state-space model
DT_sys1=c2d(CT_sys,0.2)
[F1,H1,C1,D1,Ts1]=ssdata(DT_sys1);
DT_sys2=c2d(CT_sys,0.5)
[F2,H2,C2,D2,Ts2]=ssdata(DT_sys2);
DT_sys3=c2d(CT_sys,0.8)
[F3,H3,C3,D3,Ts3]=ssdata(DT_sys3);

% Analysis
% step response
[y,t,x]=step(CT_sys);
[y1,t1,x1]=step(DT_sys1);
[y2,t2,x2]=step(DT_sys2);
[y3,t3,x3]=step(DT_sys3);
figure(1)
plot(t,x(:,1),'m','Linewidth',3), hold on
stairs(t1,x1(:,1),'b','Linewidth',2), hold on
stairs(t2,x2(:,1),'g','Linewidth',2), hold on
stairs(t3,x3(:,1),'r','Linewidth',2), hold on
title('\fontsize{24}State x_1'), legend('continuous-time','discrete-time (0.2 sec)','discrete-time (0.5 sec)','discrete-time (0.8 sec)','FontSize',16,'Location','Southeast')
xlabel('time (sec)','FontSize',16), set(gca,'FontWeight','bold','fontsize',16)
figure(2)
plot(t,x(:,2),'m','Linewidth',3), hold on
stairs(t1,x1(:,2),'b','Linewidth',2), hold on
stairs(t2,x2(:,2),'g','Linewidth',2), hold on
stairs(t3,x3(:,2),'r','Linewidth',2), hold on
title('\fontsize{24}State x_2'), legend('continuous-time','discrete-time (0.2 sec)','discrete-time (0.5 sec)','discrete-time (0.8 sec)','FontSize',16,'Location','Northeast')
xlabel('time (sec)','FontSize',16), set(gca,'FontWeight','bold','fontsize',16)
% bode diagram
figure(3)
bode(CT_sys,'m',DT_sys1,'r',DT_sys2,'g',DT_sys3,'b'), title('Bode Diagram','FontSize',24), xlabel('Frequency','FontSize',16,'FontWeight','bold')
legend('continuous-time','discrete-time (0.2 sec)','discrete-time (0.5 sec)','discrete-time (0.8 sec)','FontSize',16,'Location','southwest')
% stability
figure(4)
pzplot(CT_sys,'m')
title('\fontsize{16}Pole and Zero Location (continuous-time)'), set(gca,'FontWeight','bold','fontsize',12)
xlabel('Real axis','FontSize',12), ylabel('Imaginary axis','FontSize',12), set(gcf,'unit','normalized','position',[0.25,0.25,0.5,0.6])
figure(5)
pzplot(DT_sys1,'r',DT_sys2,'g',DT_sys3,'b')
title('\fontsize{16}Pole and Zero Location (discrete-time)'), set(gca,'FontWeight','bold','fontsize',12)
xlabel('Real axis','FontSize',12), ylabel('Imaginary axis','FontSize',12), set(gcf,'unit','normalized','position',[0.25,0.25,0.5,0.6])
legend('0.2 sec','0.5 sec','0.8 sec','FontSize',12,'Location','northeastoutside')
% controllability
Wc1=ctrb(DT_sys1);
Wc1_rank=rank(Wc1);
Wc2=ctrb(DT_sys2);
Wc2_rank=rank(Wc2);
Wc3=ctrb(DT_sys3);
Wc3_rank=rank(Wc3);
% observability
Wo1=obsv(DT_sys1);
Wo1_rank=rank(Wo1);
Wo2=obsv(DT_sys2);
Wo2_rank=rank(Wo2);
Wo3=obsv(DT_sys3);
Wo3_rank=rank(Wo3);