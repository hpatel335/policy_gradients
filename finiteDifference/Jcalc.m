function [J] = Jcalc(x_traj,u)

global Q; 
global R; 

% J = 0;
% 
% for i=1:length(x_traj)
%     
%     J = J+rewardCalc(x_traj(i),u(i));
%     
% end

J = x_traj'*Q*x_traj + u'*R*u ; 

J = J/length(x_traj);

end