function [gfd] = FD_policyGradient(K, x0, horizon) 

samples = 1e4 ; 
dK = linspace(0,0.005, samples)' ; 

dJ = [] ; 

for i = 1:samples 
    
    [x_traj, u] = dynamics(x0, horizon, K) ; 
    [x_traj_new, u_new] = dynamics(x0, horizon, K+dK(i)) ; 
%     [x_traj_new, u_new] = dynamics(x0, horizon, K*(1+dK(i))) ; 
    
    J = Jcalc(x_traj, u) ; 
    J_new = Jcalc(x_traj_new, u_new) ; 
    
    dJ = [dJ ; (J_new - J)] ; 
   
end

gfd = inv(dK'*dK)*dK'*dJ ; 


end 