function [matT] = matrix_T(betaj,betajp1,pj,pjp1);
sj = (pj.*betaj + pjp1.*betajp1)./(2.*pj.*betaj);
dj = (pj.*betaj - pjp1.*betajp1)./(2.*pj.*betaj);
T11 = sj;
T12 = dj;
T21 = dj;
T22 = sj;
matT = [T11 T12;T21 T22];
end