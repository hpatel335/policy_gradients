function [gfd] = episodicREINFORCE(K, x0, horizon, iterations) 

global sigma

% Calculating the expectation for the gradient 
gfd = 0 ;

for i = 1:iterations
    
    epsilon_j = (sigma).*randn(horizon-1,1) ;
    [x_traj_j, u_j] = dynamics(x0, horizon, K, epsilon_j)  ; 
    
    J_j = Jcalc(x_traj_j, u_j) ;
    
    epsilon_weight = sum(epsilon_j) ; 
    gfd = gfd + J_j*epsilon_weight ; 
    
end

gfd = gfd/iterations ; 

end