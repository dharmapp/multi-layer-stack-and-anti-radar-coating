%This function calculate the roots of complex numbers
%input  : any complex numbers
%output : the primary roots
function [racine] = crac(z)
r = sqrt(abs(z));
theta = angle(z);

theta1 = theta./2;

root1 = r.*(cos(theta1)+i.*sin(theta1));

racine = root1;
end
