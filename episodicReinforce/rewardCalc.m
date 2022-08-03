function [r] = rewardCalc(x,u)

global Q;
global R;

r = x'*Q*x+u'*R*u;

end