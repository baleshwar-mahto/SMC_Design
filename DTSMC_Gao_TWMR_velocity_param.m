% DT-SMC for Two Wheel Mobile Robot
% Position Model
Phi = [1 0.01; 0 0]; Gam_tau = [0;1]; C = [1 0];
p = [-2 0];                % Desired Pole location
K = place(Phi,Gam_tau,p);   % Pole placement 
c = K';
c1 = c(1)
c(2) = 0;
c2 = 0
% ct_B_inv = inv(c'*Gam_tau)
