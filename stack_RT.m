function [t,r,R,T] = stack_RT(polarization,lambda,thetad,nu,thickness,N);
k0 = 2*pi./lambda;
alfa = k0.*nu(1).*sin(thetad);
betaj = zeros(1,N+2); %N+2 medium from layer 1st to layer N
betajp1 = zeros(1,N+2); %N=1 medium from layer 2nd to layer N
betaj_square = zeros(1,N+2); %matrix for beta 2 square from medium 1st to N
betajp1_square = zeros(1,N+2); %matrix for beta 2 square from medium 1st to N
pj = zeros(1,N+2); %polarization factor in N+2 medium from layer 1st to layer N
pjp1 = zeros(1,N+2); %polarization in factor N+1 medium from layer 2nd to layer N

M = [1 0; 0 1]; %empty transfer matrix

coordy = interfaces_ordinates(thickness,N);

Tnew = 0;
Told = 0;
Cnew = 0;
Cold = 0;


%filling betaj(j), pj(j), pjp1(j)
for j=1:N+2;
    betaj_square(j) = (k0.*nu(j)).^2 - alfa.^2;    
    if polarization == 'S'
        pj(j) = 1;
    elseif polarization == 'P'
        pj(j) = 1./(nu(j).^2);
    end;
end;
betaj = crac(betaj_square);

%filling betajp1(j), pjp1(j);
for j=2:N+2;
    betajp1_square(j) = (k0.*nu(j)).^2 - alfa.^2;
    if polarization == 'S'
        pjp1(j) =1;
    elseif polarization == 'P'
        pjp1(j) = 1./(nu(j).^2);
    end;
end;
betajp1 = crac(betajp1_square);

%first medium
Told = matrix_T(betaj(1),betaj(2),pj(1),pj(2));
%Cold = matrix_C(betaj(2),thickness(1));
M = Told;


for j=2:N+1;
     Cnew = matrix_C(betaj(j),thickness(j-1));
     M = M*Cnew;
     Tnew = matrix_T(betaj(j),betaj(j+1),pj(j),pj(j+1));
     M = M*Tnew;
end;

r = M(2,1).*exp(-2*i*betaj(1).*coordy(1))./M(1,1);
t = exp(-2*i*betaj(1).*coordy(1))./(M(1,1).*exp(-2*i*betaj(N+2).*coordy(N+1)));

R = abs(r).^2;

if real(betaj(N+2)) == 0 & imag(betaj(N+2))>0;
    T = 0;
elseif real(betaj(N+2)) >0 & imag(betaj(N+2))>0;
    T = 0 ;
else;
    T = pj(N+2).*betaj(N+2).*abs(t).^2 ./ (pj(1).*betaj(1));
end;
end
