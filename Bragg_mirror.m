clc; clear all;

% This is the code to calculate transmittance and reflectance
% A-B-A-B structure at fixed thickness of each layer
% fixed angle of incidence
% wavelength is varied 
% combination of marcatilli's method to fiend effective index of each layer
% and transfer matrix to calculate the transmittance and reflectance

%Physical Constants
epsilon0  = 8.854187817e-12;      % vacuum permittivity uV/m 
mu0       = 4*pi*1e-7;            % vacuum permeability uA/m
c0        = 1/sqrt(epsilon0*mu0); % vacuum speed of light m/s

%physical parameters
iter = 1000; %numbers of variational array elements
lambda_center = [1550]; %central wavelength of operation in nm
dlambda = [500]; %wavelength half range of simulation in nm

%the following condition will help to find the central wavelength in the array easier
if mod(iter,2)==0
    iter = iter+1;
else 
    iter = iter;
end

%creating wavelength array
lambda0 = linspace(lambda_center-dlambda,lambda_center+dlambda,iter); %wavelength array

thetad = [30]; %angle of incidence (input in degree)
thetad = thetad.*pi./180; %angle of incidence convert to rad
nsup = 1 ; %index of superstrate. n=1 air, if not air n!= 1
nsub = 1; %index of substrate. n=1 air, if not air n!=1
N = 25 ; %number of stack layers 


%%%Building Bragg Mirror Structure (A-B-A-B alternating layer)%%%
%Here we define the B layer is SiN and A layer is SiO2
%We compute the ref. index of SiN and SiO2 using the function
%SiNSellmeier.m and SiO2Sellmeier.m
%both of this function use wavelength in micron for the input
n_B = SiNSellmeier(lambda0.*1e-3); %array of ref. index for layer A, for each wavelength
n_A = SiO2Sellmeier(lambda0.*1e-3); %array of ref. index for layer B, for each wavelength

%the thickness of each layer will be d=lambda/(4.n), 
% with n is refractive indices for respective layer
%as n changes with lambda, we will chose central wavelength of operation
% to calculate the thickness
idx_center = find(lambda0==lambda_center); %array position for central wavelength
d_A = lambda_center/(4*n_A(idx_center)); %thickness of layer A in nm
d_B = lambda_center/(4*n_B(idx_center)); %thickness of layer B in nm


%array to store results
%elements (1,:) for TE mode and elements (2,:) for TM mode
T = zeros(2,length(iter)); %Transmittance
R = zeros(2,length(iter)); %Reflectance
t = zeros(2,length(iter)); %Fresnel t coefficient
r = zeros(2,length(iter)); %Fresnel r coefficient


%main program begins
for k=1:iter
    %%%% defining the multi-layer problem %%%%%
    thickness_a = [d_A]*10^(-9); %layer A thicknes converted to m
    thickness_b = [d_B]*10^(-9); %layer B thickness converted to m
    
    %define refractive array which contains all medium including
    %superstrate and substrate
    nu = zeros(1,N+2);
    nu(1) = nsup; %superstrate refractive index
    nu(N+2) = nsub; %substrate refractive index
    
    %for stack layer
    for j = 2:N+1
        %first A layer is located after superstrate
        %which mean, it's located at every 'even' elements of refractive
        %index array
        if mod(j,2) == 0
            nu(j) = n_A(k); 
        %first B layer is located 2 index after superstrate
        %which mean, it's located at every 'odd' elements of refractive
        %index array
        elseif mod(j,2) ~=0
            nu(j) = n_B(k); 
        end
    end
    
    %define thickness region
    thickness = zeros(1,N);
    for j = 1:N
        if mod(j,2) == 0
            thickness(j) = thickness_b;
        elseif mod(j,2) ~= 0
            thickness(j) = thickness_a;
        end
    end
    
    %converting wavelength to m, because the multi-layer program is use
    %SI units for calculation
    lambda = lambda0(k).*10^(-9); %wavelength converted from nm to m

    %2 calculation for 2 types of polarization
    for q=1:2 
        if q==1
            polarization = 'S'; %S is for TE polarization
            [r(q,k),t(q,k),R(q,k),T(q,k)] = stack_RT(polarization,lambda,thetad,nu,...
                thickness,N);
        else
            polarization = 'P'; %P is for TM polarization
            [r(q,k),t(q,k),R(q,k),T(q,k)] = stack_RT(polarization,lambda,thetad,nu,...
                thickness,N);
        end
    end
end

%Transmittance plot
plot(lambda0,T(1,:),lambda0,T(2,:));
xlabel('\lambda [nm]');
xlim([lambda0(1) lambda0(end)]);
legend('TE','TM');
title_T = [num2str(N),' Layer ', 'Transmittance',...
    ' \theta_{incidence}= ',num2str(thetad*180/pi),'^o'];
title(title_T);

figure;
%Reflectance plot
plot(lambda0,R(1,:),lambda0,R(2,:));
xlabel('\lambda [nm]');
xlim([lambda0(1) lambda0(end)]);
legend('TE','TM');
title_R = [num2str(N),' Layer ', 'Reflectance',...
    ' \theta_{incidence}= ',num2str(thetad*180/pi),'^o'];
title(title_R);

%%plotting the refractive index variation vs wavelength 
%figure;
%plot(lambda0,n_A,lambda0,n_B);
%xlabel('\lambda [\mu m]');
%legend('n_a','n_b');
%title_n = ['Effective Indices ',num2str(N),' Layer ', polarization,...
%    '-Polarization', ' \theta_{incidence}= ',num2str(thetad*180/pi),'^o'];
%title(title_n);