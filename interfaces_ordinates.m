function [coordy] = interfaces_ordinates(thickness,N); %N is the number of layer
y = zeros(1,N+1);
sum=zeros(1,N+1);
flip_thickness = flip(thickness);
for j=1:N
    y(j+1) = flip_thickness(j);
    h = flip_thickness(j);
    y(j+1) = y(j) + h;
end;
coordy = flip(y);
end