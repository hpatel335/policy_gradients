%%%% AE 4803 Homework 3 Problem 2
%%%% Joshua Kuperman & Harsh Patel
close all
clc
clearvars

global A;
global B;
global Q;
global R; 

global sigma; 

horizon = 300;
iterations = 1000; 
x0 = 10;
M = 1000 ; 

% A = .1 ;
% B = .1 ; 
% Q = -1 ; 
% R = -1 ;

A = .6 ;
B = 0.3 ; 
Q = -1 ; 
R = -1 ;
sigma = 0.25; 
sigma_vec = linspace(sigma,0.175, iterations) ; 


gamma = 0.08;
[K_soln, S, E] = dlqr(A, B, Q, R) ; 

J = zeros(iterations,1) ; 
K = zeros(iterations-1,1) ; 
K(1) = -1 ; 
epsilon = zeros(horizon-1,1) ; 

for i = 1:iterations
    sigma = sigma_vec(i) ;
    gradient = episodicREINFORCE(K(i), x0, horizon, M) ;
    K(i+1) =  K(i) + gamma*gradient ; 
    
    [x_traj_j, u_j] = dynamics(x0, horizon, K(i+1), epsilon)  ; 
    J(i) = Jcalc(x_traj_j, u_j) ;
    
    fprintf('Iteration: %d \t Cost: %0.05f \t Gradient:  %.05f \t K: %.05f \t Sigma: %.05f \n',i,  J(i), gradient, K(i+1), sigma ) ; 

end

subplot(1,2,1) 
plot(1:iterations, K(1:iterations),'LineWidth', 2) ; 
hold on 
plot(1:iterations, -1*ones(iterations,1)*K_soln,'LineWidth', 3) 
title('Policy Profile') 
xlabel('Iterations') 
ylabel('Gain') 

subplot(1,2,2) 
plot(1:iterations, J,'LineWidth', 2) ; 
title('Cost Convergance') 
xlabel('Iterations')
ylabel('Cost') 
