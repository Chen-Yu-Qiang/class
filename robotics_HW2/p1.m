clear all

a0=0;
af0=0;
d1=358.5;

a1=50;
af1=-pi/2;
d2=0;

a2=300;
af2=0;
d3=0;

a3=350;
af3=0;
d4=35.3;

a4=0;
af4=-pi/2;
d5=251;
syms d1 d4 d5 a1 a2 a3 


th1=-1
th2=1.2
th3=0.5
th4=-1.0
th5=-1.3


syms th1 th2 th3 th4 th5
T01=trotx(af0)*transl(a0,0,0)*trotz(th1)*transl(0,0,d1)
T12=trotx(af1)*transl(a1,0,0)*trotz(th2)*transl(0,0,d2)
T23=trotx(af2)*transl(a2,0,0)*trotz(th3)*transl(0,0,d3)
T34=trotx(af3)*transl(a3,0,0)*trotz(th4)*transl(0,0,d4)
T45=trotx(af4)*transl(a4,0,0)*trotz(th5)*transl(0,0,d5)
T05=T01*T12*T23*T34*T45;
%{
t01=vpa(simplify(T01))
t12=vpa(simplify(T12))
t23=vpa(simplify(T23))
t34=vpa(simplify(T34))
t45=vpa(simplify(T45))

t04=vpa(simplify(T01*T12*T23*T34))
%}
inv(T05)
t05=T05
t14=T12*T23*T34

r11=t05(1,1);
r12=t05(1,2);
r13=t05(1,3);
r21=t05(2,1);
r22=t05(2,2);
r23=t05(2,3);
r31=t05(3,1);
r32=t05(3,2);
r33=t05(3,3);

th234=pnpi(th2+th3+th4)
th234_1=pnpi(atan2(sqrt(r13^2+r23^2),-r33))
th234_2=pnpi(atan2(-sqrt(r13^2+r23^2),-r33))
th1_1=atan2(-r23/sin(th234_1),-r13/sin(th234_1))
th5_1=atan2(r32/sin(th234_1),-r31/sin(th234_1))
th1_2=atan2(-r23/sin(th234_2),-r13/sin(th234_2))
th5_2=atan2(r32/sin(th234_2),-r31/sin(th234_2))


T14_1=inv(trotx(af0)*transl(a0,0,0)*trotz(th1_1)*transl(0,0,d1))*t05*inv(trotx(af4)*transl(a4,0,0)*trotz(th5_1)*transl(0,0,d5));
c3_1=((T14_1(1,4)-a1)^2+(T14_1(3,4))^2-a2^2-a3^2)/(2*a2*a3);
s3_1_1=sqrt(1-c3_1^2);
s3_1_2=-sqrt(1-c3_1^2);

th3_1_1=atan2(s3_1_1,c3_1)
th3_1_2=atan2(s3_1_2,c3_1)

s2c2=inv([-a3*sin(th3_1_1),(a3*cos(th3_1_1)+a2);(-a3*cos(th3_1_1)-a2),-a3*sin(th3_1_1)])*[(T14_1(1,4)-a1);T14_1(3,4)];
th2_1_1=atan2(s2c2(1),s2c2(2))
th4_1_1=th234_1-th2_1_1-th3_1_1
s2c2=inv([-a3*sin(th3_1_2),(a3*cos(th3_1_2)+a2);(-a3*cos(th3_1_2)-a2),-a3*sin(th3_1_2)])*[(T14_1(1,4)-a1);T14_1(3,4)];
th2_1_2=atan2(s2c2(1),s2c2(2))
th4_1_2=th234_1-th2_1_2-th3_1_2

T14_2=inv(trotx(af0)*transl(a0,0,0)*trotz(th1_2)*transl(0,0,d1))*t05*inv(trotx(af4)*transl(a4,0,0)*trotz(th5_2)*transl(0,0,d5));
c3_2=((T14_2(1,4)-a1)^2+(T14_2(3,4))^2-a2^2-a3^2)/(2*a2*a3);
s3_2_1=sqrt(1-c3_2^2);
s3_2_2=-sqrt(1-c3_2^2);

th3_2_1=atan2(s3_2_1,c3_2)
th3_2_2=atan2(s3_2_2,c3_2)


s2c2=inv([-a3*sin(th3_2_1),(a3*cos(th3_2_1)+a2);(-a3*cos(th3_2_1)-a2),-a3*sin(th3_2_1)])*[(T14_2(1,4)-a1);T14_2(3,4)];
th2_2_1=atan2(s2c2(1),s2c2(2))

s2c2=inv([-a3*sin(th3_2_2),(a3*cos(th3_2_2)+a2);(-a3*cos(th3_2_2)-a2),-a3*sin(th3_2_2)])*[(T14_2(1,4)-a1);T14_2(3,4)];
th2_2_2=atan2(s2c2(1),s2c2(2))

th4_2_1=th234_2-th2_2_1-th3_2_1
th4_2_2=th234_2-th2_2_2-th3_2_2


ans1=[th1_1,th2_1_1,th3_1_1,th4_1_1,th5_1];
ans2=[th1_1,th2_1_2,th3_1_2,th4_1_2,th5_1];
ans3=[th1_2,th2_2_1,th3_2_1,th4_1_1,th5_2];
ans4=[th1_2,th2_2_2,th3_2_2,th4_2_2,th5_2];


all_ans=[ans1;ans2;ans3;ans4]

a0=0;
af0=0;
d1=358.5;

a1=50;
af1=-pi/2;
d2=0;

a2=300;
af2=0;
d3=0;

a3=350;
af3=0;
d4=35.3;

a4=0;
af4=-pi/2;
d5=251;
%DH = [THETA D A ALPHA]
L1 =  Link([ 0, d1, a0, af0], 'modified');
L2 =  Link([ 0, d2, a1, af1], 'modified');
L3 =  Link([ 0, d3, a2, af2], 'modified');
L4 =  Link([ 0, d4, a3, af3], 'modified');
L5 =  Link([ 0, d5, a4, af4], 'modified');
%robot=SerialLink([L1,L2,L3,L4,L5])
%robot.display()
%robot.plot([0,0,0,0,0]);
%robot.teach