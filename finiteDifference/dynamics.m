function [x_traj,u] = dynamics(x0,horizon,K)

global A;
global B;

x_traj = zeros(horizon-1,1);
x_traj(1) = x0;
u = zeros(horizon-1,1);

for i=1:horizon
    u(i) = x_traj(i)*K;
    randNum = randn(1,1)*0.05;
    x_traj(i+1) = A*x_traj(i)+B*u(i)+randNum;
end
u(end+1) = x_traj(end)*K;

end