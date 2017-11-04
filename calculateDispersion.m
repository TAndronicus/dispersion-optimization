function [ dispersion ] = calculateDispersion( neff, lambda )
%CALCULATEDISPERSION Calculates dispersion given neff and lambda
%   Detailed explanation goes here
if(length(lambda) > 2)
    for i=2:length(lambda)-1
        dispersion(i-1)=-10^6*lambda(i)*(neff(i+1)-2*neff(i)+neff(i-1))/(3*10^8*(lambda(2)-lambda(1))^2);
    end
else
    dispersion = [];
end
end

