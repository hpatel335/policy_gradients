function [x_traj,u] = dynamics(x0,horizon,K, noise)

global A;
global B;

x_traj = zeros(horizon-1,1);
x_traj(1) = x0;
u = zeros(horizon-1,1);
mag = 0; 

for i=1:(horizon-1)
    u(i) = x_traj(i)*(K + noise(i)) ; 
    x_traj(i+1) = A*x_traj(i)+B*u(i) + mag*randn;
end

% u(end) = x_traj(end)*(K + noise(end)) ; 

end