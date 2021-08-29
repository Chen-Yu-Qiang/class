Ac=[-3 1;0 -2];
Bc=[0;1];
Cc=[1 0];
h=0.2
sysC=ss(Ac,Bc,Cc,[])
sysD=c2d(sysC,h)

K=place(sysD.A,sysD.B,roots([1 -0.63 0.21]))
%K=place([0.55 0.12;0 0.67],[0.01;0.16],roots([1 -0.63 0.21]))

%%

u=out.simout.Data;
u_t=out.simout.Time;
y=out.simout2.Data;
y_t=out.simout2.Time;
x1=out.simout1.Data(:,1);
x2=out.simout1.Data(:,2);
x_t=out.simout1.Time;


subplot(311)
hold on
plot(x_t,x1,x_t,x2)
xlabel("Time(s)")
legend("State x_1","State x_2")
grid on


subplot(312)
hold on
plot(y_t,y)
xlabel("Time(s)")
legend("Output y")
grid on


subplot(313)
hold on
stairs(u_t,u,"LineWidth",2,"Color",	[0 0 0])
xlabel("Time(s)")
legend("Input u")
grid on