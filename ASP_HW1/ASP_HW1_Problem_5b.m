R=[1.1 0.5 0.1;0.5 1.1 0.5;0.1 0.5 1.1];
p=[0.5;-0.4;-0.2];
sd2=1.0;


w_opt=inv(R)*p;
ASP_Wiener_MSE(R,w_opt,p,sd2)