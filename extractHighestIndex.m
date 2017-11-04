function [ index ] = extractHighestIndex(geometryTypeShort, numberOfLayers, coreDiameter, doping, latticeConstant, holeDiameter)
%extractHighestIndex Returns highest index taken into cosideration
%   Detailed explanation goes here

fileName = [geometryTypeShort '_' num2str(numberOfLayers) '_d_' num2str(doping) '_ddo_' num2str(coreDiameter,'%04.2f') '_dr_' num2str(latticeConstant,'%04.2f') '_dh_' num2str(holeDiameter,'%04.2f') '.mat'];
load(fileName);
dispersion = calculateDispersion(neff, lambda);
if(~isempty(dispersion))
    index = length(dispersion);
    if(dispersion(index) > 0)
        while(dispersion(index) > 0) %Aeff doesnt have to be checked at this point
            if(index == 1)
                break;
            end
            index = index - 1;
        end
        index = index + 1;
    end
else
    index = 0;
end

end

