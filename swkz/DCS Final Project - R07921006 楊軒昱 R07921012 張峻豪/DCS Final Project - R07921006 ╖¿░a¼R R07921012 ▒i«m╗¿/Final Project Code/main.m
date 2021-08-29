%% Initialization
clear; clc;

sys_yaw_dynamics = [-0.0868 -1; 2.14 -0.228];
sys_roll2yaw_couple = [-0.0391 0; 0 -0.0204];
sys_roll_dynamics = [0 1; 0 -1.181];
sys_yaw2roll_couple = [0 0; -4.41 0.334];

A = [sys_yaw_dynamics, sys_roll2yaw_couple; 
     sys_yaw2roll_couple, sys_roll_dynamics];

input_yaw_dynamics = [0.0222; -1.165];
input_roll2yaw_couple = [0; -0.0652];
input_roll_dynamics = [0; -2.11];
input_yaw2roll_dynamics = [0; 0.549];

B = [input_yaw_dynamics, input_roll2yaw_couple;
     input_yaw2roll_dynamics, input_roll_dynamics];

output_yaw = [10 0];
output_roll = [10 0];

C = [output_yaw, [0 0]; 
    [0 0], output_roll];

E = C;
%% Find eigenvalue and eigenvector, check Controlability and observability
clc;

[plant_eigvec, plant_eigval] = eig(A);

Stability = rank(A);

CO = ctrb(A, B);
OB = obsv(A, C);

disp(strcat('Controlability: rank(CO)= ', num2str(rank(CO)), ...
     ', rank(A)= ', num2str(rank(A))))

disp(strcat('Observability: rank(OB)= ', num2str(rank(OB)), ...
     ', rank(A)= ', num2str(rank(A))))
 
%% State feedback control using LQR
clc;

Q = 1*eye(4);
R = 0.01*eye(2);

K_lqr  = lqr(A,B,Q,R);
Kr_lqr = -(E*((A-B*K_lqr)^-1)*B)^-1;

%% Discrete Controller design
clc;

% Sampling time h = 0.2
Ts = 0.2;
% State-space model in continuous time
sys = ss(A, B, C, []);

% Transform the continuous system into discrete form in h = 0.2
sys = c2d(sys,Ts, 'zoh');
% sys = c2d(sys,Ts, 'foh');

% Obtain the discrete state-space model 
[F,H,C_dis,D_dis] = ssdata(sys);

CO_dis = ctrb(F, H);
OB_dis = obsv(F, C_dis);

Stability_dis = rank(F);
Con_dis = rank(CO_dis);
Obs_dis = rank(OB_dis);

% Discrete model lqr
K_lqr_dis1  = lqrd(A,B,Q,R, 0.2);
Kr_lqr_dis1 = -(E*((A-B*K_lqr_dis1)^-1)*B)^-1;

K_lqr_dis2  = lqrd(A,B,Q,R, 1);
Kr_lqr_dis2 = -(E*((A-B*K_lqr_dis2)^-1)*B)^-1;

K_lqr_dis3  = lqrd(A,B,Q,R, 2);
Kr_lqr_dis3 = -(E*((A-B*K_lqr_dis3)^-1)*B)^-1;




