function [matC] = matrix_C(betaj,thickness);
C11 = exp(-i.*betaj.*thickness);
C12 = 0;
C21 = 0;
C22 = exp(i.*betaj.*thickness);
matC = [C11 C12; C21 C22];
end
