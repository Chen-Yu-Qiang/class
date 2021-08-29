function [T05] = fk(th1,th2,th3,th4,th5)
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



T01=trotx(af0)*transl(a0,0,0)*trotz(th1)*transl(0,0,d1);
T12=trotx(af1)*transl(a1,0,0)*trotz(th2)*transl(0,0,d2);
T23=trotx(af2)*transl(a2,0,0)*trotz(th3)*transl(0,0,d3);
T34=trotx(af3)*transl(a3,0,0)*trotz(th4)*transl(0,0,d4);
T45=trotx(af4)*transl(a4,0,0)*trotz(th5)*transl(0,0,d5);
T05=T01*T12*T23*T34*T45;
end

