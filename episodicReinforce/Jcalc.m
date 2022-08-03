function [J] = Jcalc(x_traj,u)

global Q; 
global R; 

J = x_traj'*Q*x_traj + u'*R*u ; 

J = J/length(x_traj);

end