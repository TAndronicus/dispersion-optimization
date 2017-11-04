function [  ] = computeFiber(lambdaStart, lambdaEnd, lambdaStep, geometryTypeShort, numberOfLayers, coreDiameter, claddingDiameter, doping, latticeConstant, holeDiameter, saveFiles, displayStep)
%computeFiber Computes neff, neff_imag, Aeff, n2eff for given fiber
%   Detailed explanation goes here
import com.comsol.model.*
import com.comsol.model.util.*

format long;
primaryMode = 4; %definded in Comsol model

geometryType = getGeometryTypeFromShort(geometryTypeShort);

model = mphload([geometryType '.mph'],'Model');
ModelUtil.showProgress(true);

model.param.set('ddo',[num2str(coreDiameter) '[um]']);
model.param.set('d',num2str(doping/100));
model.param.set('dh',[num2str(holeDiameter) '[um]']);
model.param.set('dclad',[num2str(claddingDiameter) '[um]']);
if(geometryTypeShort == 'h')
    model.param.set('dr',[num2str(latticeConstant) '[um]']);
else
    model.param.set('lattice',[num2str(latticeConstant) '[um]']);
end

lambda = (lambdaStart:lambdaStep:lambdaEnd)';
lambda=lambda*1e-9;

index=length(lambda);
if(saveFiles)
    catalogName = getNameOfCatalog(geometryTypeShort, numberOfLayers, doping, coreDiameter, latticeConstant, holeDiameter);
end

for i = 1:length(lambda)
    model.param.set('lambda0',[num2str(lambda(i)*1e6,15) '[um]']);
    if i == 1
        neff_init = 1.5;
    elseif i == 2
        neff_init = neff_follow(i-1);
    else
        neff_init = 2*neff_follow(i-1) - neff_follow(i-2);
    end
    model.study('std1').feature('mode').set('shift', num2str(neff_init, 15));
    model.study('std1').run;
    if(displayStep)
        index=index-1;
        disp(index)
    end
    
    neff_all = mphglobal(model,{'real(ewfd.neff)'});
    neff(i) = neff_all(primaryMode);
    neff_follow(i) = neff(i);
    neff_imag_all = mphglobal(model,{'imag(ewfd.neff)'});
    neff_imag(i) = neff_imag_all(primaryMode);
    Aeff_all = mphglobal(model,{'Aeff'});
    Aeff(i) = Aeff_all(primaryMode);
    damping_all = mphglobal(model,{'ewfd.dampzdB'});
    damping(i) = damping_all(primaryMode);
    n2eff_all = mphglobal(model,{'n2eff'});
    n2eff(i) = n2eff_all(primaryMode);
    if(saveFiles)
        mphsave(model, [pwd '\' catalogName '\lambda_' num2str(lambda(i)) '.mph'])
    end
end

fileName = getNameOfFileNoCut(geometryTypeShort, numberOfLayers, doping, coreDiameter, latticeConstant, holeDiameter);
save(fileName, 'lambda', 'neff', 'neff_imag', 'Aeff', 'damping', 'n2eff')

end

