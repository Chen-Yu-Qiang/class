clear all
load('ASP_HW4_Problem_3.mat')
R=zeros(11);
for i=1:1000
    R=R+(matX(:,i)*matX(:,i)')/1000;
end
R
eig(R)
x=[]
y=[]
for th=-90:0.01:90
    x=[x th];
    yi=1/(A(th/180*pi)'*inv(R)*A(th/180*pi));
    y=[y yi];
end
subplot(2,1,1)
plot(x,abs(y))
grid on
xlabel("\theta(deg)")
ylabel("Magnitude")
title("ASP HW4 Problem3(c)--MVDR Spectrum")
subplot(2,1,2)
grid on
plot(x,angle(y)*180/pi)
xlabel("\theta(deg)")
title("ASP HW4 Problem3(c)--MVDR Spectrum")
ylabel("Phase(deg)")

[a,b]=findpeaks(abs(y));
for i=1:length(a)
    if x(b(i))>=0 && x(b(i))<=10
        fprintf("theta =%d deg is peak\n",x(b(i)))
    end
end
x=[];
y1=[];
y2=[];
y3=[];
for th=-pi/2:0.01:pi/2
    x=[x th];
    y1=[y1 B_theta_uni(th)];
    y2=[y2 B_theta_array(th)];
    y3=[y3 B_theta_MVDR(th,R)];
end
figure
plot(x,db(y1),x,db(y2),x,db(y3))
grid on
xlabel("\theta(rad)")
title("ASP HW4 Problem3(e)--beampattern")
ylabel("|B_\theta(\theta)|(db)")
legend("Uniform weights","Array steering with DOA \theta_s","MVDR beamformer with DOA \theta_s")


x=[];
y1=[];
y2=[];
y3=[];
for t=1:1000
    x=[x t];
    y1=[y1 y_uni(matX(:,t))];
    y2=[y2 y_array(matX(:,t))];
    y3=[y3 y_MVDR(matX(:,t),R)];
end
figure
subplot(2,1,1)
plot(x,real(y1),x,real(y2),x,real(y3))
grid on
xlabel("time t")
title("ASP HW4 Problem3(f)--output")
ylabel("real part")
legend("Uniform weights","Array steering with DOA \theta_s","MVDR beamformer with DOA \theta_s")
subplot(2,1,2)
plot(x,imag(y1),x,imag(y2),x,imag(y3))
grid on
xlabel("time t")
title("ASP HW4 Problem3(f)--output")
ylabel("imaginary part")
legend("Uniform weights","Array steering with DOA \theta_s","MVDR beamformer with DOA \theta_s")




function a=A(theta)
    a=[];
    for i=1:11
        a(i)=exp((1i)*2*pi*sin(theta)*(i-1)*0.5);
    end
    a=a.';
end


function b=B_theta_uni(theta)
    b=1/11*abs(sin(11/2*pi*sin(theta))/sin(1/2*pi*sin(theta)));
end

function b=B_theta_array(theta)
    ts=3.25/180*pi;
    w=1/11*A(ts);
    b=abs(w'*A(theta));
end

function b=B_theta_MVDR(theta,R)
    ts=3.25/180*pi;
    w=(inv(R)*A(ts))/(A(ts)'*inv(R)*A(ts));
    b=abs(w'*A(theta));
end


function y=y_uni(x)
    w=ones(11,1)/11;
    y=w'*x;
end

function y=y_array(x)
    ts=3.25/180*pi;
    w=1/11*A(ts);
    y=w'*x;
end

function y=y_MVDR(x,R)
    ts=3.25/180*pi;
    w=inv(R)*A(ts)/(A(ts)'*inv(R)*A(ts));
    y=w'*x;
end