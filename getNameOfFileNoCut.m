function [ plik ] = getNameOfFileNoCut(geometryTypeShort, numberOfLayers, doping, coreDiameter, latticeConstant, holeDiameter)
%GETNAMEOFFILE Summary of this function goes here
%   Detailed explanation goes here

plik = [geometryTypeShort '_' num2str(numberOfLayers) '_d_' num2str(doping) '_ddo_' num2str(coreDiameter,'%04.2f') '_dr_' num2str(latticeConstant,'%04.2f') '_dh_' num2str(holeDiameter,'%04.2f') 'NoCut.mat'];

end

