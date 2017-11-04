function [ optimizedParameter ] = optimizeParameter(parameter, stepNumber, drStartValue, dhStartValue, actualIncrement, lowestIncrement, lambdaStart, lambdaEnd, lambdaStep, geometryTypeShort, numberOfLayers, coreDiameter, claddingDiameter, doping, saveFiles, displayStepWhenCalculatingFiber)
%OPTIMIZEPARAMETER Summary of this function goes here
%   Detailed explanation goes here
if(strcmp(parameter, 'dr'))
    drIncrement = actualIncrement;
    dhIncrement = 0;
else
    dhIncrement = actualIncrement;
    drIncrement = 0;
end
previousValue = 0;
latticeConstant = drStartValue;
holeDiameter = dhStartValue;
while(true)
    if(strcmp(parameter, 'dr'))
        parameterValue = latticeConstant;
    else
        parameterValue = holeDiameter;
    end
    disp(['Step ' num2str(stepNumber) ': ' parameter ' = ' num2str(parameterValue)])
    fileName = getNameOfFile(geometryTypeShort, numberOfLayers, doping, coreDiameter, latticeConstant, holeDiameter);
    if(not(exist(fileName, 'file')))
        computeFiber(lambdaStart, lambdaEnd, lambdaStep, geometryTypeShort, numberOfLayers, coreDiameter, claddingDiameter, doping, latticeConstant, holeDiameter, saveFiles, displayStepWhenCalculatingFiber);
        cutAeff(geometryTypeShort, numberOfLayers, doping, coreDiameter, latticeConstant, holeDiameter);
    end
    value = extractHighestIndex(geometryTypeShort, numberOfLayers, coreDiameter, doping, latticeConstant, holeDiameter);
    holeDiameter = holeDiameter + dhIncrement;
    latticeConstant = latticeConstant + drIncrement;
    if(previousValue >= value)
        break;
    end
    previousValue = value;
    stepNumber = stepNumber + 1;
end

holeDiameter = holeDiameter - dhIncrement;
latticeConstant = latticeConstant - drIncrement;

if(actualIncrement ~= lowestIncrement)
    optimizedParameter = optimizeParameter(parameter, stepNumber + 1, latticeConstant, holeDiameter, lowestIncrement, lowestIncrement, lambdaStart, lambdaEnd, lambdaStep, geometryTypeShort, numberOfLayers, coreDiameter, claddingDiameter, doping, saveFiles, displayStepWhenCalculatingFiber);
else
    if(strcmp(parameter, 'dr'))
        optimizedParameter = latticeConstant;
    else
        optimizedParameter = holeDiameter;
    end
end

end

