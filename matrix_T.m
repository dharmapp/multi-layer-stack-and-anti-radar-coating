%This function calculate the matrix that describes transition between
%adjacent medium interfaces
%Input  : 
%   betaj       = propagation constant in medium j
%   betapj1     = propagation constant in medium j+1
%   pj          = polarization factor in medium j
%   pjp1        = polarization factor in medium j+1
%   thickness   = thickness of medium j
%   all the inputs are in the SI units

%Output :
%   A 2x2 matrix with elements that describes a propagation of E fields
%   inside a medium
function [matT] = matrix_T(betaj,betajp1,pj,pjp1);
sj = (pj.*betaj + pjp1.*betajp1)./(2.*pj.*betaj);
dj = (pj.*betaj - pjp1.*betajp1)./(2.*pj.*betaj);
T11 = sj;
T12 = dj;
T21 = dj;
T22 = sj;
matT = [T11 T12;T21 T22];
end
