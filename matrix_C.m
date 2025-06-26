%This function calculate the matrix that describes propagation inside a medium
%Input  : 
%   betaj       = propagation constant in medium j
%   thickness   = thickness of medium j
%   all the inputs are in the SI units

%Output :
%   A 2x2 matrix with elements that describes a propagation of E fields
%   inside a medium

function [matC] = matrix_C(betaj,thickness);
C11 = exp(-i.*betaj.*thickness);
C12 = 0;
C21 = 0;
C22 = exp(i.*betaj.*thickness);
matC = [C11 C12; C21 C22];
end
