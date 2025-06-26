%Input: wavelength (lambda in micron)
%Output: refractive index and refractive index dispersion for SiO2
%valid for wavelength in range 0.21 um to 6.7 um 

function [n,dndk0] = SiO2Sellmeier(lambda)
A = 0.6961663;
B = 0.4079426;
C = 0.0684043;
D = 0.1162414;
E = 0.8974794;
F = 9.896161;

n_square = 1 + (A.*lambda.^2)./(lambda.^2 - C.^2) + (B.*lambda.^2)./(lambda.^2 - D.^2)+(E.*lambda.^2)./(lambda.^2 - F.^2);
n = sqrt(n_square);

ndn = A.*lambda./(lambda.^2 - C.^2) - (A.*lambda.^3)/((lambda.^2 - C.^2).^2) ...
    + B.*lambda/(lambda.^2 - D.^2) - (B.*lambda.^3)/((lambda.^2 - D.^2).^2)...
    + E.*lambda/(lambda.^2 - F.^2) - (E.*lambda.^3)/((lambda.^2 - F.^2).^2);

dndlambda = ndn./n; %dispersion of index @lambda [micron^-1]

%convert micron variables into m
lambda = lambda*1e-6;
dndlambda = dndlambda*10^6; %from micron^-1 to m^-1
dndk0 = dndlambda.*(lambda.^2)./(2*pi);
end