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
T05=transl(600,100,0)*trotx(pi)*troty(0)*trotz(pi/2.5)
px=T05(1,4);
py=T05(2,4);
pz=T05(3,4);

pr=sqrt(px^2+py^2);
pth=atan2(py,px);
prr=sqrt(pr^2-(35.3)^2);
pth2=asin(35.3/pr);
th1=pth-pth2;

qz=358.5-251-pz;
qr=sqrt(qz^2+prr^2);
qrr=sqrt(qz^2+(prr-50)^2);
qth=atan2(qz,(prr-50));
qth2=acos((300^2+qrr^2-350^2)/(2*300*qrr));
th2=qth-qth2;
th3=pi-acos((300^2+350^2-qrr^2)/(2*300*350));
th4=-atan(qz/(prr-50))-acos((350^2+qrr^2-300^2)/(2*qrr*350));

th5=atan2(-T05(2,1),T05(1,1))+th1;
th=[th1,th2,th3,th4,th5].*180/pi
fk(th1,th2,th3,th4,th5)
L1 =  Link([ 0, d1, a0, af0], 'modified');
L2 =  Link([ 0, d2, a1, af1], 'modified');
L3 =  Link([ 0, d3, a2, af2], 'modified');
L4 =  Link([ 0, d4, a3, af3], 'modified');
L5 =  Link([ 0, d5, a4, af4], 'modified');
robot=SerialLink([L1,L2,L3,L4,L5])
robot.teach([th1,th2,th3,th4,th5])
robot.plot([th1,th2,th3,th4,th5]);
saveas(gcf,"c2c.png")
