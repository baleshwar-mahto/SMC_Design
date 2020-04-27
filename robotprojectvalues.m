clear all; close all; clc;
Xr_c=5;
Yr_c=0;
c   =0.5;
b   =0.75;
d   =1;
% Kp  = 30; Kd = 10; Ki  = 15;
% Kp  = 8; Kd = 8; Ki  = 1; 
% Kp  = 2.5; Kd = 0; Ki  = 3;

% Xc          = 20; % xc 
% Yc          = 10; % yc
% fai         = -pi/2; % fai
% theta_R     = 0 ; % theta right
% theta_L     = 0; % theta left
% theta_dot_R = 0; % theta dot right
% theta_dot_L = 0; % theta dot left
I_c         = 1 ; %
I_w         = 100 ;
m_c         = 20 ;
m_w         = 15 ;
I_m         = 15;
%
%% Parameters for position model
Phi_pos = [1 0.01; 0 1]; Gam_tau_pos = [5e-5; 0.01]; C = [1 0];
p_pos_s_dmoain = [-900 -800];
p_pos_z_dmoain = exp(p_pos_s_dmoain*0.01)
p_pos = p_pos_z_dmoain;         % Desired Pole Location in z-domain
% p_pos = [-50 -20];                % Desired Pole location
% p_pos = [-2 -1];
K_pos = place(Phi_pos,Gam_tau_pos,p_pos);   % Pole placement 
c_pos = K_pos';
c1_pos = c_pos(1)
c2_pos = c_pos(2)
tau = 0.01; 
mu = 200;
x = (1-mu*tau);
%% Parameters for new_dtsmc_velocity simulink model
phi_vel = [1 0.01;0 0]; % system matrix
Gam_tau_vel = [0;1];
%% Velocity Model Parameters
v_pos_s_dmoain = [-100 -200];
v_pos_z_dmoain = exp(v_pos_s_dmoain*0.01)
v_pos = v_pos_z_dmoain;         % Desired Pole Location in z-domain
% v_vel_ = [-2 -1];                % Desired Pole location
K_vel = place(phi_vel,Gam_tau_vel,v_pos);   % Pole placement 
c_vel = K_vel';
c1_vel = c_vel(1);
c2_vel = c_vel(2);
%%
% dm =  0.1;
dm = 0.1;
esp = 0.1;
tau = 0.01; % Sampling time
y = dm-esp*tau;
mu =  250;
a =   c_vel'*phi_vel-(1-mu*tau)*c_vel';
m1 =  a(1)
m2 =  a(2)

%%
sim('mobilerobot_DT_SMC')
close all
t = ScopeData2.time;
for k = 1:length(t)
    f = ScopeData_reference.signals.values(:,:,k);
    xd(k) = f(1);
    yd(k) = f(2);
% yd = ScopeData_reference.signals.values(:);
end
xr = ScopeData2.signals.values(:,1);
yr = ScopeData2.signals.values(:,2);
% figure;plot(xd,yd, xr,yr);
figure;scatter(xd,yd); hold on; scatter(xr,yr);
% grid on; title('Change in position in y-direction');xlabel('Time(sec)'); ylabel('Position in y-direction'); axis([0 15 4 8]); % For position shift in Y-direction
% grid on; title('Path following on circular track');xlabel('x-position'); ylabel('y-posiiton'); 
grid on; title('Path following on straight line');xlabel('x-position'); ylabel('y-posiiton'); 
% axis([0 10 -2 10]);
legend('Desired position','Robot position')
