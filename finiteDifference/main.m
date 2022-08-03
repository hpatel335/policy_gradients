
close all
clc
clearvars

global A;
global B;
global Q;
global R; 

horizon = 100;
iterations = 200 ; 
x0 = 10;
x_target = 0;

K = [0.5];
gfd = 0 ; 

A = .1 ;
B = .1 ; 
Q = -1 ; 
R = -1 ;

% converge = 1e-5;
gamma = 0.1;
% diff = converge+1;

[K_soln, S, E] = dlqr(A, B, Q, R) ; 

% figure() 
% hold on 
J_vec = [] ; 

for i = 1:iterations

    policy = K(end) ; 
    gfd = FD_policyGradient(policy, x0, horizon) ; 
    K(end+1) =  K(end) + gamma*gfd; 
    
%     plot(i, K(end), 'bo') ; 
    
%     plot(i, gfd, 'bx') ; 
    [x_traj, u] = dynamics(x0, horizon, K(end)) ; 
    J = Jcalc(x_traj, u) ; 
    J_vec = [J_vec, J];  
%     plot(i, J,'ko') ; 
    
    fprintf('gFD, K:  %.05f \t %.05f \n', gfd, K(end) ) ; 
    
    
end
subplot(1,2,1) 
plot(1:iterations, J_vec, 'LineWidth', 2) 
title('Cost Profile') 
xlabel('Iterations') 
ylabel('Cost')

subplot(1,2,2) 
plot(1:(iterations+1), K, 'LineWidth', 2) 
title('Policy Profile') 
xlabel('Iterations') 
ylabel('Policy')

hold on 
plot(1:iterations, -1*ones(iterations,1)*K_soln,'LineWidth', 3) 



