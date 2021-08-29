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


th1=(rand()-0.5)*2*pi;
th2=(rand()-0.5)*2*pi;
th3=(rand()-0.5)*2*pi;
th4=(rand()-0.5)*2*pi;
th5=(rand()-0.5)*2*pi;

a=fk(th1,th2,th3,th4,th5);
a=transl(600,100,0)*trotx(pi)*troty(0)*trotz(pi/4)
b=ik(a);
b.*180/pi
for i=1:4
    err=abs(a-fk(b(i,1),b(i,2),b(i,3),b(i,4),b(i,5)))
    L1 =  Link([ 0, d1, a0, af0], 'modified');
    L2 =  Link([ 0, d2, a1, af1], 'modified');
    L3 =  Link([ 0, d3, a2, af2], 'modified');
    L4 =  Link([ 0, d4, a3, af3], 'modified');
    L5 =  Link([ 0, d5, a4, af4], 'modified');
    robot=SerialLink([L1,L2,L3,L4,L5])
    robot.teach([b(i,1),b(i,2),b(i,3),b(i,4),b(i,5)])
    robot.plot([b(i,1),b(i,2),b(i,3),b(i,4),b(i,5)]);
    saveas(gcf,num2str(i)+"1.png")
end