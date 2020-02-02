
% DT-SMC for Two Wheel Mobile Robot
% Position Model
Phi = [1 0.01; 0 1]; Gam_tau = [5e-5; 0.01]; C = [1 0];
p = [-2 -1];                % Desired Pole location
K = place(Phi,Gam_tau,p);   % Pole placement 
c = K';
c1 = c(1)
c2 = c(2)
% ct_B_inv = inv(c'*Gam_tau)
