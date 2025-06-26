%Input: wavelength (lambda in micron)
%Output: refractive index and refractive index dispersion for SiN
%valid for wavelength in range 0.31 um to 5.5 um 

function [n,dndk0] = SiNSellmeier(lambda)
A = 3.0249;
B = 40314;
C = 0.1353406;
D = 1239.842;

n_square = 1 + (A.*lambda.^2)./(lambda.^2 - C.^2) + (B.*lambda.^2)./(lambda.^2 - D.^2);
n = sqrt(n_square);

ndn = A.*lambda./(lambda.^2 - C.^2) - (A.*lambda.^3)/((lambda.^2 - C.^2).^2) ...
    + B.*lambda/(lambda.^2 - D.^2) - (B.*lambda.^3)/((lambda.^2 - D.^2).^2);

dndlambda = ndn./n; %dispersion of index @lambda [micron^-1]

%convert micron variables into m
lambda = lambda*1e-6;
dndlambda = dndlambda*10^6; %from micron^-1 to m^-1
dndk0 = dndlambda.*(lambda.^2)./(2*pi);
end