function [drOpt, dhOpt2] = searchForOptimum(doping, geometryTypeShort)
%SEARCHFOROPTIMUM Summary of this function goes here
%   Detailed explanation goes here

geometryType = getGeometryTypeFromShort(geometryTypeShort);
displayStepWhenCalculatingFiber = false;
saveFiles = true;
dhStartValue = .1;
if(doping == 20)
    coreDiameter = 3;
    drStartValue = ceil(10 * coreDiameter / .9) / 10; % seed .1
    lambdaStart = 2000;
    lambdaEnd = 3000;
else
    coreDiameter = 2.5;
    drStartValue = ceil(10 * coreDiameter / .9) / 10;
    lambdaStart = 2500;
    lambdaEnd = 3500;
end
lambdaStep = 10;
numberOfLayers = 3;
claddingDiameter = 125;

disp(['Starting optimization: ' geometryType ', doping: ' num2str(doping)])
disp('I step - first dh optimisation')
latticeConstant = 2 * coreDiameter;
holeDiameter = dhStartValue;
stepNumber = 1;

dhOpt1 = optimizeParameter('dh', stepNumber, latticeConstant, holeDiameter, .05, .05, lambdaStart, lambdaEnd, lambdaStep, geometryTypeShort, numberOfLayers, coreDiameter, claddingDiameter, doping, saveFiles, displayStepWhenCalculatingFiber);

disp(['I step result dhOpt1 = ' num2str(dhOpt1)])

disp('II step - dr optimisation')
latticeConstant = drStartValue;
holeDiameter = dhOpt1;
stepNumber = 1;

drOpt = optimizeParameter('dr', stepNumber, latticeConstant, holeDiameter, .2, .1, lambdaStart, lambdaEnd, lambdaStep, geometryTypeShort, numberOfLayers, coreDiameter, claddingDiameter, doping, saveFiles, displayStepWhenCalculatingFiber);

disp(['II step result after ' num2str(stepNumber) ' steps: drOpt = ' num2str(drOpt)])

disp('III step - second dh optimisation')
stepNumber = 1;
holeDiameter = dhStartValue;
latticeConstant = drOpt;

dhOpt2 = optimizeParameter('dh', stepNumber, latticeConstant, holeDiameter, .05, .05, lambdaStart, lambdaEnd, lambdaStep, geometryTypeShort, numberOfLayers, coreDiameter, claddingDiameter, doping, saveFiles, displayStepWhenCalculatingFiber);

disp(['III step result after ' num2str(stepNumber) ' steps: dhOpt2 = ' num2str(dhOpt2)])

disp([geometryType ', doping: ' num2str(doping) ', drOpt: ' num2str(drOpt) ', dhOpt: ' num2str(dhOpt2)])
disp(' ')
    
end

