function [  ] = cutAeff( geometryTypeShort, numberOfLayers, doping, coreDiameter, latticeConstant, holeDiameter )
%CUTAEFF Summary of this function goes here
%   Detailed explanation goes here

fileName = [geometryTypeShort '_' num2str(numberOfLayers) '_d_' num2str(doping) '_ddo_' num2str(coreDiameter,'%04.2f') '_dr_' num2str(latticeConstant,'%04.2f') '_dh_' num2str(holeDiameter,'%04.2f') 'NoCut.mat'];
load(fileName);
index = 2;
while(Aeff(index)*10^12 < 30 && index < length(lambda))
    index = index + 1;
end
index  = index - 1;
lambda = lambda(1:index);
neff = neff(1:index);
neff_imag = neff_imag(1:index);
Aeff = Aeff(1:index);
damping = damping(1:index);
n2eff = n2eff(1:index);
newFileName = getNameOfFile(geometryTypeShort, numberOfLayers, doping, coreDiameter, latticeConstant, holeDiameter);
save(newFileName, 'lambda', 'neff', 'neff_imag', 'Aeff', 'damping', 'n2eff')

end

